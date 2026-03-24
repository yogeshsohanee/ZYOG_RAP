@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection View of Billing Document Item'
@Metadata.allowExtensions: true
define view entity zsac_c_bill_item as projection on zsac_i_bill_item
{
    key BillId,
    key ItemNo,
    MaterialId,
    Description,
    Quantity,
    ItemAmount,
    Currency,
    Uom,
    CreatedBy,
    CreateDat,
    LastChangedBy,
    LastChangeDat,
    LocalLastChangedat,
    /* Associations */
    _header : redirected to parent zsac_c_bill_header
}
