// FiveNet - a form

#define CenterScreen  1

function Main()

   local oForm := CreateForm()
   local bOnClick := { | oSender | MsgInfo( "click" ) } 
   
   oForm:Text = "FiveNet"
   oForm:Width = 400
   oForm:StartPosition = CenterScreen
   
   oForm:OnMouseDown = PBlock( @bOnClick ) 
   
   AppRun( oForm )

return nil