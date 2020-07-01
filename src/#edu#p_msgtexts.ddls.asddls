@EndUserText.label: 'Messages Texts'
@AccessControl.authorizationCheck: #CHECK
@UI: {
    headerInfo: { 
        typeName: 'Text',
        typeNamePlural: 'Texts',
        title: {  type: #STANDARD, label: 'Message Id', value: 'msgid' },
        description: { type: #STANDARD, label: 'Message No', value: 'msgno' }
    }
}
define root view entity /EDU/P_MSGTEXTS as projection on /EDU/I_MSGTEXTS
{
      @UI: {
        lineItem:       [ { position: 10, importance: #HIGH } ],
        identification: [ { position: 10, label: 'Language' } ]
      }
  key langu,

      @UI: {
        lineItem:       [ { position: 20, importance: #HIGH } ],
        identification: [ { position: 20, label: 'Message Id' } ]
      }
  key msgid,

      @UI: {
        lineItem:       [ { position: 30, importance: #HIGH } ],
        identification: [ { position: 30, label: 'Message No' } ]
      }
  key msgno,

      @UI: {
        lineItem:       [ { position: 40, importance: #MEDIUM } ],
        identification: [ { position: 40, label: 'Text' } ]
      }
      text,
      text2
}
