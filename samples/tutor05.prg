// A MDI form with a toolbar and a statusbar

#define CenterScreen 1

function Main()

   local oForm    := CreateForm()
   local oToolBar := CreateToolStrip()
   local bOnClick := { | sender | BuildChild( oForm ) }
   local oStatusBar := CreateStatusStrip()
   local bOnMenuItem := { | cItem | MsgInfo( cItem ) }

   oForm:Text = "A MDI form with a toolbar and a statusbar"
   oForm:Width = 895
   oForm:Height = 578
   oForm:StartPosition = CenterScreen
   oForm:IsMdiContainer = .T.
   
   CreateMainMenu( oForm )
   MenuAddItem( oForm, "&File" )
   MenuAddItem( oForm, "&Edit" )
   MenuAddItem( oForm, "&Window" )
   MenuAddItem( oForm, "&Help" )
   oForm:OnMenuItem = PBlock( @bOnMenuItem )

   oToolBar:AddButton()
   oToolBar:AddButton()
   oToolBar:AddButton()
   oToolBar:AddButton()

   oToolBar:OnClick = PBlock( @bOnClick )

   AddControl( oForm, oToolBar )
   AddControl( oForm, oStatusBar )

   AppRun( oForm )

return nil

function BuildChild( oParent )

   local oForm := CreateForm()

   oForm:MdiParent = oParent
   oForm:Text = "Child form"
   oForm:Show()
   
return nil   
   