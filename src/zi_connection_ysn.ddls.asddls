@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Connection view CDS Data Model'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@UI.headerInfo: {
    typeName: 'Connection',
    typeNamePlural: 'Connections'
}
@Search.searchable: true
define view entity ZI_Connection_Ysn
  as select from /dmo/connection as Connection
  association [1..*] to ZI_FLIGHT_TECH_YSN  as _Flight  on  $projection.CarrierId    = _Flight.CarrierId
                                                        and $projection.ConnectionId = _Flight.ConnectionId
  association [1]    to ZI_CARRIER_TECH_YSN as _Airline on  $projection.CarrierId = _Airline.CarrierId
{
      @UI.facet: [{ id: 'Connection',
          purpose: #STANDARD,
                      type: #IDENTIFICATION_REFERENCE,
                      position: 10,
                      label: 'Connection Detail'},
                      {
                      id: 'Flight',
                      purpose: #STANDARD,
                      type: #LINEITEM_REFERENCE,
                      position: 20,
                      label: 'Flights',
                      targetElement: '_Flight'
                      }
                      ]
      @UI.lineItem: [{ position: 10, label: 'Airline', importance: #HIGH}]
      @UI.identification: [{ position: 10, label: 'Airline'}]
      @ObjectModel.text.association: '_Airline'
      @Search.defaultSearchElement: true
  key carrier_id      as CarrierId,
      @UI.lineItem: [{ position: 20 }]
      @UI.identification: [{ position: 20 }]
  key connection_id   as ConnectionId,
      @UI.lineItem: [{ position: 30 }]
      @UI.selectionField: [{ position: 10 }]
      @UI.identification: [{ position: 30 }]
      @Search.defaultSearchElement: true
      @Consumption.valueHelpDefinition: [{ entity:{
        name: 'ZI_AIRPORT_YSN_VH',
        element: 'AirportId'
      } }]
      @EndUserText.label: 'Departure Aiport ID'
      airport_from_id as AirportFromId,
      @UI.selectionField: [{ position: 20 }]
      @UI.lineItem: [{ position: 40 }]
      @UI.identification: [{ position: 40 }]
      @Search.defaultSearchElement: true
      @Consumption.valueHelpDefinition: [{entity: {
        name: 'ZI_AIRPORT_YSN_VH',
        element: 'AirportId'
      }}]
      @EndUserText.label: 'Destination Airport ID'
      airport_to_id   as AirportToId,
      @UI.lineItem: [{ position: 50, label: 'Departure Time' }]
      @UI.identification: [{ position: 50 }]
      departure_time  as DepartureTime,
      @UI.lineItem: [{ position: 60, label: 'Arrival Time'}]
      @UI.identification: [{ position: 60 }]
      arrival_time    as ArrivalTime,
      @Semantics.quantity.unitOfMeasure: 'DistanceUnit'
      @UI.identification: [{ position: 70 }]
      distance        as Distance,
      distance_unit   as DistanceUnit,
      @Search.defaultSearchElement: true
      _Flight,
      @Search.defaultSearchElement: true
      _Airline
}
