// (c) FiveTech Software 2011, GPL v3 licence

using System;
using System.Windows.Forms;
using System.Drawing;
using System.Runtime.InteropServices;
using System.Xml.Serialization;
using System.Xml;
using System.IO;
using System.Reflection;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;

namespace FiveTech
{
	 public class TForm : Form
	 {
	    public new uint OnMouseDown;
	    public uint OnMenuItem;

      public void SaveAsXML( string cFileName )
      {
		     PropertyDescriptorCollection properties = TypeDescriptor.GetProperties( this );
		     XmlWriter writer;
		     XmlWriterSettings settings = new XmlWriterSettings();
         
         settings.Indent = true;
         settings.IndentChars = "  ";
         
         writer = XmlWriter.Create( cFileName, settings );
         writer.WriteStartElement( "form" );
         
		     foreach ( PropertyDescriptor prop in properties )
			   {
				    try
				    {
					     if( prop.PropertyType.IsSerializable )
					     {
                  writer.WriteStartElement( "property" );
                  writer.WriteElementString( "name",  prop.Name );
                  writer.WriteElementString( "type",  prop.GetValue( this ).GetType().Name );
                  writer.WriteElementString( "value", prop.GetValue( this ).ToString() );
                  writer.WriteEndElement();
                  // writer.Flush();
						   }   	
				    }
				    catch( Exception ex )
				    {
					     System.Diagnostics.Trace.WriteLine( ex.Message );
					     writer.WriteEndElement();	
				    }
			   }
			   
         writer.WriteEndElement();
         writer.Close(); 
      }      	

      public void ReadFromXML( string cFileName )
      {
		     PropertyDescriptorCollection properties = TypeDescriptor.GetProperties( this );
         FileStream stream = new FileStream( cFileName, FileMode.Open, FileAccess.Read, FileShare.Read );
         XmlTextReader reader = new XmlTextReader( stream );
         Hashtable propTypes = new Hashtable();
         Hashtable propValues = new Hashtable();
         string name;

         reader.MoveToContent();
         reader.ReadStartElement();
    
         while( reader.Read() )
         {
            if( reader.NodeType == XmlNodeType.Element && reader.Name == "name" )
            {
               name	= reader.ReadString();
               reader.ReadToNextSibling( "type" );
               propTypes[ name ] = reader.ReadString();
               reader.ReadToNextSibling( "value" );
               propValues[ name ] = reader.ReadString();
               // MessageBox.Show( name + " - " + ( string ) propTypes[ name ] + " - " + ( string ) propValues[ name ] ); 
            }   
         }              	   	

         foreach( PropertyDescriptor prop in properties )
         {
            if( propTypes.Contains( prop.Name ) )
            {
               string type = ( string ) propTypes[ prop.Name ];
               string value = ( string ) propValues[ prop.Name ];
               
               if( String.Compare( type, "Boolean" ) == 0 )
                  prop.SetValue( this, String.Compare( value, "True" ) == 0 );

               if( String.Compare( type, "Int32" ) == 0 )
                  prop.SetValue( this, System.Convert.ToInt32( value, 10 ) );

               if( String.Compare( type, "String" ) == 0 )
                  prop.SetValue( this, value );
            }
         } 

         stream.Close();
      }      	
	 }	
	 
	 public class TButton : Button
	 {
	    public new uint OnClick;
	 }   	

	 public class TComboBox : ComboBox
	 {
	    public uint OnChange;
	 }   	

   public class TToolStrip : ToolStrip
   {
      public new uint OnClick;

      public void AddButton()
      {
      	 ToolStripButton btn = new ToolStripButton();

         Items.Add( new ToolStripButton() );
      }
   }       
    	
   public class FiveNet
   {
      // public string AppName;
     
      [ DllImport ( "ftsnet.dll", CallingConvention = CallingConvention.Cdecl ) ]
      public static extern void One( uint pBlock );	

      [ DllImport ( "ftsnet.dll", CallingConvention = CallingConvention.Cdecl ) ]
      public static extern void Two( uint pBlock, [ MarshalAs( UnmanagedType.Struct ) ] object sender );	

      [ DllImport ( "ftsnet.dll", CallingConvention = CallingConvention.Cdecl ) ]
      public static extern void Three( uint pBlock, [ MarshalAs( UnmanagedType.Struct ) ] object sender, [ MarshalAs( UnmanagedType.Struct ) ] object ev );	
 
      public FiveNet()
      {}

      public Form CreateForm()
      {
         Form form = new TForm(); 

         form.MouseDown += new System.Windows.Forms.MouseEventHandler( Form_MouseDown );
      
         return form;
      } 
      
      public Label CreateLabel()
      {
         Label label = new Label();
         
         return label;
      }    

      public TextBox CreateTextBox()
      {
         TextBox text = new TextBox();
         
         return text;
      }    

      public Button CreateButton()
      {
         Button button = new TButton();

         button.Click += new System.EventHandler( Button_Click );
         
         return button;
      }    

      public ComboBox CreateComboBox()
      {
         ComboBox combo = new TComboBox();

         combo.SelectedIndexChanged += new System.EventHandler( Combo_Change );
         
         return combo;
      }    

      public MainMenu CreateMainMenu( Form form )
      {
         MainMenu menu = new MainMenu();
         
         form.Menu = menu;
         
         return menu;
      }   	

      public void MenuAddItem( Form form, string cItem )
      {
      	 MenuItem mit = new MenuItem( cItem );
      	 
      	 mit.Click += new System.EventHandler( MenuItem_Click );
      	 
         form.Menu.MenuItems.Add( mit );
         mit.Tag = form;
      }

      public ContextMenuStrip CreateMenu( Form form )
      {
         ContextMenuStrip menu = new ContextMenuStrip();
         
         form.ContextMenuStrip = menu;
         menu.Name = "default";
         
         return menu;
      }   	

      public MenuStrip CreateMenuStrip( Form form )
      {
         MenuStrip menu = new MenuStrip();
         
         form.MainMenuStrip = menu;
         menu.Name = "main";
         
         return menu;
      }   	
         	
      public PropertyGrid CreatePropertyGrid()
      {
         PropertyGrid pg = new PropertyGrid();
         
         return pg;
      }   	   	
         	
      public TToolStrip CreateToolStrip()
      {
         TToolStrip tool = new TToolStrip();
         
         tool.ItemClicked += new ToolStripItemClickedEventHandler( ToolStrip_ItemClicked );

         return tool;
      }    

      public StatusStrip CreateStatusStrip()
      {
         StatusStrip status = new StatusStrip();
         
         return status;
      }    

      public void AddControl( object form, object control )
      {
         ( ( TForm ) form ).Controls.Add( ( Control ) control );
      }   	

      private void Form_MouseDown( object sender, System.Windows.Forms.MouseEventArgs e )
		  {
		     Two( ( ( TForm ) sender ).OnMouseDown, sender );
		  }   	

      private void Button_Click( object sender, System.EventArgs e )
		  {
		     Two( ( ( TButton ) sender ).OnClick, sender );
		  }   	

      private void Combo_Change( object sender, System.EventArgs e )
		  {
		     Two( ( ( TComboBox ) sender ).OnChange, sender );
		  }   	

      private void ToolStrip_ItemClicked( object sender, System.EventArgs e )
		  {
		     Two( ( ( TToolStrip ) sender ).OnClick, sender );
		  }   	

      private void MenuItem_Click( object sender, System.EventArgs e )
		  {
		  	 TForm form = ( TForm ) ( ( MenuItem ) sender ).Tag;
		  	 
		     Two( form.OnMenuItem, ( ( MenuItem ) sender ).Text );
		  }   	
     
      public void Run( Form form )
      {
         Application.Run( form );
      }   	 
     
      public int MsgInfo( string cMsg )
      {
         return ( int ) MessageBox.Show( cMsg, "Information" );
      }   
   }
}
