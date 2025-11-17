@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Booking Supplement Projection view Managed'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Metadata.allowExtensions: true
define view entity ZC_BOOKSUPPL_YSN
  as projection on ZI_BOOKSUPPL_YSN
{
  key TravelId,
  key BookingId,
  key BookingSupplementId,
      @ObjectModel.text: {
          element: [ 'SupplementDesc' ]
      }
      SupplementId,
      _SupplementText.Description as SupplementDesc : localized,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      Price,
      
      CurrencyCode,
      LastChangedAt,
      /* Associations */
      _Booking : redirected to parent ZC_BOOKING_YSN,
      _Supplement,
      _SupplementText,
      _Travel  : redirected to ZC_TRAVEL_YSN
}
