// (c) FiveTech Software 2011, GPL2 licence

#xcommand TRY              => bError := errorBlock( {|oErr| break( oErr ) } ) ;;
                              BEGIN SEQUENCE
#xcommand CATCH [<!oErr!>] => errorBlock( bError ) ;;
                              RECOVER [USING <oErr>] <-oErr-> ;;
                              errorBlock( bError )
                               
#define MB_ICONEXCLAMATION    0x00000030                               
                                 
static oFiveNet

init procedure FiveNet

   local bError

   if oFiveNet == nil
      try
         oFiveNet = win_oleCreateObject( "FiveTech.FiveNet" )
      catch bError
         wapi_MessageBox( 0, "Can't create object 'FiveTech.FiveNet'",;
                          "Please use register.bat", MB_ICONEXCLAMATION )
      end
   endif

return

exit procedure __exit

   oFiveNet = nil
   
return  

function MsgInfo( cMsg )

   if oFiveNet != nil
      return oFiveNet:MsgInfo( cMsg )
   endif

return nil

function CreateForm()

   if oFiveNet != nil
      return oFiveNet:CreateForm()
   endif

return nil

function CreateLabel()

   if oFiveNet != nil
      return oFiveNet:CreateLabel()
   endif

return nil

function CreateTextBox()

   if oFiveNet != nil
      return oFiveNet:CreateTextBox()
   endif

return nil

function CreateButton()

   if oFiveNet != nil
      return oFiveNet:CreateButton()
   endif

return nil

function CreateComboBox()

   if oFiveNet != nil
      return oFiveNet:CreateComboBox()
   endif

return nil

function CreateMainMenu( oForm )

   if oFiveNet != nil
      return oFiveNet:CreateMainMenu( oForm )
   endif

return nil

function CreateMenuStrip( oForm )

   if oFiveNet != nil
      return oFiveNet:CreateMenuStrip( oForm )
   endif

return nil

function CreateMenu( oForm )

   if oFiveNet != nil
      return oFiveNet:CreateMenu( oForm )
   endif

return nil

function CreatePropertyGrid()

   if oFiveNet != nil
      return oFiveNet:CreatePropertyGrid()
   endif

return nil

function MenuAddItem( oForm, cItem )

   if oFiveNet != nil
      return oFiveNet:MenuAddItem( oForm, cItem )
   endif

return nil

function CreateToolStrip()

   if oFiveNet != nil
      return oFiveNet:CreateToolStrip()
   endif

return nil

function CreateStatusStrip()

   if oFiveNet != nil
      return oFiveNet:CreateStatusStrip()
   endif

return nil

function Serialize( cFileName, oForm )

   if oFiveNet != nil
      return oFiveNet:Serialize( cFileName, oForm )
   endif

return nil

function AppRun( oForm )

   if oFiveNet != nil
      return oFiveNet:Run( oForm )
   endif

return nil

function AddControl( oForm, oControl )

   if oFiveNet != nil
      return oFiveNet:AddControl( oForm, oControl )
   endif

return nil

#pragma BEGINDUMP

#include <hbapi.h>
#include <hbapiitm.h>
#include <windows.h>

HB_FUNC( PBLOCK )
{
   hb_retnl( ( LONG ) hb_param( 1, HB_IT_BLOCK ) );
}   

void _export FNET1( unsigned long pBlock )
{
   if( pBlock )
      hb_evalBlock0( ( PHB_ITEM ) pBlock );
}

HRESULT hb_oleVariantToItem( PHB_ITEM pItem, VARIANT * pVariant );

void _export FNET2( unsigned long pBlock, VARIANT * sender )
{
   PHB_ITEM pSender = hb_itemNew( NULL );

   // MessageBox( 0, "inside FNET2", "ok", 0 );
   
   if( sender )
   {
      // MessageBox( 0, "sender is ok", "ok", 0 );
      hb_oleVariantToItem( pSender, sender );
   }   

   // hb_itemPutNL( pSender, sender->n1.n2.vt ); 

   if( pBlock )
      hb_evalBlock1( ( PHB_ITEM ) pBlock, pSender );
      
   hb_itemRelease( pSender );   
}

void _export FNET3( unsigned long pBlock, VARIANT * sender, VARIANT * event )
{
   PHB_ITEM pSender = hb_itemNew( NULL );
   PHB_ITEM pEvent  = hb_itemNew( NULL );
   
   // MessageBox( 0, "inside FNET3", "ok", 0 );
   
   hb_oleVariantToItem( pSender, sender );
   hb_oleVariantToItem( pEvent, event );

   if( pBlock )
      hb_evalBlock( ( PHB_ITEM ) pBlock, pSender, pEvent, 0 );
}

#pragma ENDDUMP  