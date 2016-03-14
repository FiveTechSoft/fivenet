// FiveNet - Placing several controls on a form

#define CenterScreen  1

function Main()

   local oForm := CreateForm()
   local bOnClick := { | oSender | MsgInfo( oSender:Height ) } 
   local oLabel, oText, oButton, oCombo
   local bBtnClick := { | oSender | MsgInfo( oText:Text ) }
   local bCbxChange := { | oSender | MsgInfo( "Combo" ) }
   
   oForm:Text = "Using controls"
   oForm:Width = 367
   oForm:Height = 247
   oForm:StartPosition = CenterScreen
   
   oForm:OnMouseDown = PBlock( @bOnClick ) 
   
   oLabel = CreateLabel()
   oLabel:Top = 17
   oLabel:Left = 15
   olabel:Width = 40
   oLabel:Text = "Name:"
   
   AddControl( oForm, oLabel )
   
   oText = CreateTextBox()
   oText:Top = 15
   oText:Left = 70
   oText:Width = 100
   oText:Text = "Write here..."

   AddControl( oForm, oText )
   
   oButton = CreateButton()
   oButton:Top = 140
   oButton:Left = 120
   oButton:Text = "Value"
   oButton:OnClick = PBlock( @bBtnClick )
   
   AddControl( oForm, oButton )
   
   oCombo = CreateComboBox()
   oCombo:Top = 60
   oCombo:Left = 170
   oCombo:Text = "Value"
   oCombo:OnChange = PBlock( @bCbxChange )
   // oCombo:Items:Add( "one" )  

   AddControl( oForm, oCombo )
   
   AppRun( oForm )

return nil