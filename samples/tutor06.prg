// Using a Property Grid

// Form Start Position
#define Manual 0

// Form Border style
#define SizeableToolWindow 6

// Dock values
#define Fill 5

function Main()

   local oForm := CreateForm()
   local oInspector := CreateForm()
   local oPG := CreatePropertyGrid()
   local bOnClick := { || oForm:ReadFromXML( "test.xml" ) }

   oForm:StartPosition = Manual
   oForm:Top = 213
   oForm:Left = 215
   oForm:Width = 464
   oForm:Height = 332
   oForm:OnMouseDown = PBlock( @bOnClick )
   
   CreateMenuStrip( oForm )
   CreateMenu( oForm )

   oInspector:FormBorderStyle = SizeableToolWindow
   oInspector:StartPosition = Manual
   oInspector:Top = 131
   oInspector:Left = 759
   oInspector:Height = 532
   oInspector:Width = 368
 
   oPG:Dock = Fill
   oPG:SelectedObject = oForm

   AddControl( oInspector, oPG )
   oInspector:Visible = .T.

   AppRun( oForm )

return nil
   