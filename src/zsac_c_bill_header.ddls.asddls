@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection View of Billing Doc Header'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity zsac_c_bill_header 
provider contract transactional_query
as projection on ZSAC_I_Bill_Header
{
    key BillId,
    BillType,
    BillDate,
    CustomerId,
    @Semantics.amount.currencyCode: 'Currency'
    NetAmount,
    Currency,
    SalesOrg,
    CreatedBy,
    CreateDat,
    LastChangedBy,
    LastChangeDat,
    LocalLastChangeDat,
    
    _item: redirected to composition child zsac_c_bill_item
}
