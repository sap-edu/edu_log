@AbapCatalog.sqlViewName: '/EDU/IMSGTEXTS'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@Search.searchable: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Messages Texts'
define root view /EDU/I_MSGTEXTS as select from /edu/msg_texts {
      @Semantics.language: true
  key langu,
  
      @Search.defaultSearchElement: true
  key msgid,
  
      @Search.defaultSearchElement: true
  key msgno,
  
      @Semantics.text: true
      @Search.defaultSearchElement : true
      @Search.fuzzinessThreshold: 0.7
      @EndUserText.label: 'Text'
      text,
      text2
}

