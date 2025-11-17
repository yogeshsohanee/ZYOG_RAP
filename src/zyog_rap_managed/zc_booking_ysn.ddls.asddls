@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Booking Projection view Managed'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Metadata.allowExtensions: true
define view entity ZC_BOOKING_YSN
  as projection on ZI_BOOKING_YSN
{
  key TravelId,
  key BookingId,
      BookingDate,
      @ObjectModel.text: {
          element: [ 'CustomerName' ]
      }
      CustomerId,
      _Customer.LastName         as CustomerName,
      @ObjectModel.text: {
          element: [ 'CarrierName' ]
      }
      CarrierId,
      _Carrier.Name              as CarrierName,
      ConnectionId,
      FlightDate,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      FlightPrice,
      CurrencyCode,
      @ObjectModel.text.element: [ 'BookingStatusText' ]
      BookingStatus,
      _Booking_Status._Text.Text as BookingStatusText : localized,
      LastChangedAt,
      /* Associations */
      _Booksuppl : redirected to composition child ZC_BOOKSUPPL_YSN,
      _Carrier,
      _Connection,
      _Customer,
      _Booking_Status,
      _Travel    : redirected to parent ZC_TRAVEL_YSN
}
