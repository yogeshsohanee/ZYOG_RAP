@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Root entity for Billing Header'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZSAC_I_Bill_Header
  as select from zsac_bill_header
  composition [0..*] of zsac_i_bill_item as _item
{
  key bill_id            as BillId,
      bill_type          as BillType,
      bill_date          as BillDate,
      customer_id        as CustomerId,
      @Semantics.amount.currencyCode : 'Currency'
      net_amount         as NetAmount,
      currency           as Currency,
      sales_org          as SalesOrg,
      @Semantics.user.createdBy: true
      createdby          as CreatedBy,
      @Semantics.systemDateTime.createdAt: true
      createdat          as CreateDat,
      @Semantics.user.lastChangedBy: true
      lastchangedby      as LastChangedBy,
      @Semantics.systemDateTime.lastChangedAt: true
      lastchangedat      as LastChangeDat,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      locallastchangedat as LocalLastChangeDat,
      
      _item
}
