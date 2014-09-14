USE AirQuality ;

DROP TABLE IF EXISTS AtmosObsrv ;

CREATE EXTERNAL TABLE AtmosObsrv 
(
    MeasYrMo STRING,
    Statidentifier STRING,
    Statnumber INT,
    Obsrvervationtime STRING,
    Statlatitude DOUBLE,
    Statlongitude DOUBLE,
    Statelevation DOUBLE,
    ShowalterIdx DOUBLE,
    LiftedIdx DOUBLE,
    LIFTcomputedusingVRTemp DOUBLE,
    SWEATIdx DOUBLE,
    KIdx DOUBLE,
    CrosstotalsIdx DOUBLE,
    VerticaltotalsIdx DOUBLE,
    TotalstotalsIdx DOUBLE,
    ConvAvailPotentialEnergy DOUBLE,
    CAPEusingVRTemp DOUBLE,
    ConvInhibition DOUBLE,
    CINSusingVRTemp DOUBLE,
    EquilibrumLvl DOUBLE,
    EquilibrumLvlusingVRTemp DOUBLE,
    LvlofFreeConvection DOUBLE,
    LFCTusingVRTemp DOUBLE,
    BulkRichardsonNumber DOUBLE,
    BulkRichardsonNumberusingCAPV DOUBLE,
    TempKoftheLiftedCondLvl DOUBLE,
    PreshPaoftheLiftedCondLvl DOUBLE,
    MeanmixedlayerpotentialTemp DOUBLE,
    Meanmixedlayermixingratio DOUBLE,
    OneKhPato500hPathickness DOUBLE,
    PrecipH20mmforentiresounding DOUBLE,
    PreshPa DOUBLE,
    HghtM INT,
    TempC DOUBLE,
    DwPtC DOUBLE,
    RelHPct INT,
    Mixrgpkg DOUBLE,
    Drctdeg INT,
    Skntknot INT,
    THTA_k DOUBLE,
    THTE DOUBLE,
    THTV DOUBLE
)
ROW FORMAT 
    DELIMITED FIELDS TERMINATED BY '|'
    LINES TERMINATED BY '\n'
STORED AS TEXTFILE
LOCATION '/data/AirQuality/UWyo/AtmosObsrv'
;

