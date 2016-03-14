// FiveNet - Placing controls on a form

#define CenterScreen  1

function Main()

   local oForm := CreateForm()
   local bOnClick := { | oSender | MsgInfo( "click" ) } 
   local oLabel
   
   oForm:Text = "FiveNet"
   oForm:Width = 400
   oForm:StartPosition = CenterScreen
   
   oForm:OnMouseDown = PBlock( @bOnClick ) 
   
   oLabel = CreateLabel()
   oLabel:Top = 100
   oLabel:Left = 100
   oLabel:Text = "Hello world"
   
   AddControl( oForm, oLabel )
   
   AppRun( oForm )

return nil