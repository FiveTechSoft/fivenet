#include <windows.h>

#pragma argsused

//------------------------------------------------------------------------//

BOOL WINAPI DllEntryPoint( HINSTANCE hinstDLL, DWORD fdwReason, 
                           LPVOID lpvReserved )
{
   return TRUE;
}

//------------------------------------------------------------------------//

typedef void ( * PFUNC ) ( unsigned long );

void WINAPI _export Test( unsigned long pBlock )
{
   char szName[ 300 ];
   HMODULE hEXE;
   FARPROC pFunc;
   
   GetModuleFileName( NULL, szName, 299 );
   // MessageBox( 0, szName, "Inside FtsNet", 0 );	
   
   hEXE = LoadLibrary( szName );
   pFunc = GetProcAddress( hEXE, "_FNET1" );

   if( pFunc )
      ( ( PFUNC ) pFunc )( pBlock );

   FreeLibrary( hEXE );   
}

//------------------------------------------------------------------------//

typedef void ( * PTWO ) ( unsigned long, VARIANT * );

void WINAPI _export Two( unsigned long pBlock, VARIANT sender )
{
   char szName[ 300 ];
   HMODULE hEXE;
   FARPROC pFunc;
   
   GetModuleFileName( NULL, szName, 299 );
   // MessageBox( 0, szName, "Inside Two()", 0 );	
   
   hEXE = LoadLibrary( szName );
   pFunc = GetProcAddress( hEXE, "_FNET2" );

   /*
   if( ! sender )
      MessageBox( 0, "sender is NULL", "ok", 0 );

   switch( sender.n1.n2.vt )
   {
      case VT_EMPTY || VT_NULL:	
         MessageBox( 0, "variant vacio", "ok", 0 ); 	
         break;
         
      case VT_VARIANT:
         MessageBox( 0, "variant VARIANT", "ok", 0 ); 	
         break;

      case VT_UNKNOWN:
         MessageBox( 0, "variant IUnknown", "ok", 0 ); 	
         break;
         
      default:
      	 MessageBox( 0, "variant de otro tipo", "ok", 0 );
      	 break;   
    }
    */      	   

   if( pFunc )
      ( ( PTWO ) pFunc )( pBlock, &sender );

   FreeLibrary( hEXE );   
}

//------------------------------------------------------------------------//

typedef void ( * PTHREE ) ( unsigned long, VARIANT *, VARIANT * );

void WINAPI _export Three( unsigned long pBlock, VARIANT * sender, VARIANT * event )
{
   char szName[ 300 ];
   HMODULE hEXE;
   FARPROC pFunc;
   
   GetModuleFileName( NULL, szName, 299 );
   MessageBox( 0, szName, "Inside Three()", 0 );	
   
   hEXE = LoadLibrary( szName );
   pFunc = GetProcAddress( hEXE, "_FNET3" );

   if( pFunc )
      ( ( PTHREE ) pFunc )( pBlock, sender, event );

   FreeLibrary( hEXE );   
}

//------------------------------------------------------------------------//