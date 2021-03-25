*&---------------------------------------------------------------------*
*& Report ZANK_P_STRATEGRY_PATTERN
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zank_p_strategry_pattern.

*===============================================================================================
* Problem : You have to encrypt a file.
* For small files -->
*  ( let's say for files < 1 gb ) the complete file is read and kept in memory
* For large files -->
*   Parts of the file are read in memory and partial encrypted results are stored in tmp files
*===============================================================================================

*---------------------
* Strategy Interface
*---------------------
INTERFACE if_encryption_technique.
  METHODS: encrypt.
ENDINTERFACE.

*---------------------
* Concrete Strategies
*---------------------

CLASS cl_encrypt_in_memory DEFINITION.
PUBLIC SECTION.
  INTERFACES if_encryption_technique.
ENDCLASS.

CLASS cl_encrypt_in_memory IMPLEMENTATION.
  METHOD if_encryption_technique~encrypt.
    WRITE: |Encrypted in memory|.
  ENDMETHOD.
ENDCLASS.

CLASS cl_encrypt_in_disk DEFINITION.
PUBLIC SECTION.
  INTERFACES if_encryption_technique.
ENDCLASS.

CLASS cl_encrypt_in_disk IMPLEMENTATION.
  METHOD if_encryption_technique~encrypt.
    WRITE: |Encrypted in disk|.
  ENDMETHOD.
ENDCLASS.

*----------------------------------------------
* Encryption provider class a.k.a 'the context'
*----------------------------------------------

CLASS cl_encryption_provider DEFINITION.
PUBLIC SECTION.
  METHODS: constructor IMPORTING file TYPE i.
  METHODS: encrypt_file.

PRIVATE SECTION.
  DATA: encryptor TYPE REF TO if_encryption_technique.

ENDCLASS.

CLASS cl_encryption_provider IMPLEMENTATION.
  METHOD: constructor.
    encryptor = COND #( WHEN file < 10 THEN NEW cl_encrypt_in_memory( )
                        ELSE NEW cl_encrypt_in_disk( )  ).
  ENDMETHOD.

  METHOD: encrypt_file.
    encryptor->encrypt( ).
  ENDMETHOD.
ENDCLASS.

*----------------------------------------------
* Driver code a.k.a 'the client'
*----------------------------------------------
START-OF-SELECTION.

DATA(encryption_provider) = NEW cl_encryption_provider( file = 9  ).
encryption_provider->encrypt_file( ).

NEW-LINE.
CLEAR:  encryption_provider.
encryption_provider = NEW cl_encryption_provider( file = 12  ).
encryption_provider->encrypt_file( ).
