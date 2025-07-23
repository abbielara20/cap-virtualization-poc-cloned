using {managed} from '@sap/cds/common';

@cds.persistence.exists
entity V_IPRODUCT {
    MANDT                          : String(3);
    PRODUCT                        : String(40);
    PRODUCTEXTERNALID              : String(40);
    PRODUCTOID                     : String(128);
    PRODUCTTYPE                    : String(4);
    CREATIONDATE                   : String(8);
    CREATIONTIME                   : String(6);
    CREATIONDATETIME               : Decimal(21, 7);
    CREATEDBYUSER                  : String(12);
    LASTCHANGEDATE                 : String(8);
    LASTCHANGEDBYUSER              : String(12);
    ISMARKEDFORDELETION            : String;
    CROSSPLANTSTATUS               : String(2);
    CROSSPLANTSTATUSVALIDITYDATE   : String(8);
    PRODUCTOLDID                   : String(40);
    GROSSWEIGHT                    : Decimal(13, 3);
    PURCHASEORDERQUANTITYUNIT      : String(3);
    SOURCEOFSUPPLY                 : String;
    WEIGHTUNIT                     : String(3);
    COUNTRYOFORIGIN                : String(3);
    COMPETITORID                   : String(10);
    PRODUCTGROUP                   : String(9);
    BASEUNIT                       : String(3);
    ITEMCATEGORYGROUP              : String(4);
    NETWEIGHT                      : Decimal(13, 3);
    PRODUCTHIERARCHY               : String(18);
    DIVISION                       : String(2);
    VARBLPURORDUNITISACTIVE        : String;
    VOLUMEUNIT                     : String(3);
    MATERIALVOLUME                 : Decimal(13, 3);
    SALESSTATUS                    : String(2);
    TRANSPORTATIONGROUP            : String(4);
    SALESSTATUSVALIDITYDATE        : String(8);
    AUTHORIZATIONGROUP             : String(4);
    ANPCODE                        : String(9);
    PRODUCTCATEGORY                : String(2);
    BRAND                          : String(4);
    PROCUREMENTRULE                : String;
    VALIDITYSTARTDATE              : String(8);
    LOWLEVELCODE                   : String(3);
    PRODNOINGENPRODINPREPACKPROD   : String(40);
    SERIALIDENTIFIERASSGMTPROFILE  : String(4);
    SIZEORDIMENSIONTEXT            : String(32);
    INDUSTRYSTANDARDNAME           : String(18);
    PRODUCTSTANDARDID              : String(18);
    INTERNATIONALARTICLENUMBERCAT  : String(2);
    PRODUCTISCONFIGURABLE          : String;
    ISBATCHMANAGEMENTREQUIRED      : String;
    HASEMPTIESBOM                  : String;
    EXTERNALPRODUCTGROUP           : String(18);
    CROSSPLANTCONFIGURABLEPRODUCT  : String(40);
    SERIALNOEXPLICITNESSLEVEL      : String;
    PRODUCTMANUFACTURERNUMBER      : String(40);
    MANUFACTURERNUMBER             : String(10);
    MANUFACTURERPARTPROFILE        : String(4);
    QLTYMGMTINPROCMTISACTIVE       : String;
    ISAPPROVEDBATCHRECORDREQD      : String;
    HANDLINGINDICATOR              : String(4);
    WAREHOUSEPRODUCTGROUP          : String(4);
    WAREHOUSESTORAGECONDITION      : String(2);
    STANDARDHANDLINGUNITTYPE       : String(4);
    SERIALNUMBERPROFILE            : String(4);
    ADJUSTMENTPROFILE              : String(3);
    PREFERREDUNITOFMEASURE         : String(3);
    ISPILFERABLE                   : String;
    ISRELEVANTFORHZDSSUBSTANCES    : String;
    QUARANTINEPERIOD               : Decimal(3);
    TIMEUNITFORQUARANTINEPERIOD    : String(3);
    QUALITYINSPECTIONGROUP         : String(4);
    HANDLINGUNITTYPE               : String(4);
    HASVARIABLETAREWEIGHT          : String;
    MAXIMUMPACKAGINGLENGTH         : Decimal(15, 3);
    MAXIMUMPACKAGINGWIDTH          : Decimal(15, 3);
    MAXIMUMPACKAGINGHEIGHT         : Decimal(15, 3);
    MAXIMUMCAPACITY                : Decimal(15, 3);
    OVERCAPACITYTOLERANCE          : Decimal(3, 1);
    UNITFORMAXPACKAGINGDIMENSIONS  : String(3);
    BASEUNITSPECIFICPRODUCTLENGTH  : Decimal(13, 3);
    BASEUNITSPECIFICPRODUCTWIDTH   : Decimal(13, 3);
    BASEUNITSPECIFICPRODUCTHEIGHT  : Decimal(13, 3);
    PRODUCTMEASUREMENTUNIT         : String(3);
    PRODUCTVALIDSTARTDATE          : String(8);
    ARTICLECATEGORY                : String(2);
    CONTENTUNIT                    : String(3);
    NETCONTENT                     : Decimal(13, 3);
    COMPARISONPRICEQUANTITY        : Decimal(5);
    GROSSCONTENT                   : Decimal(13, 3);
    PRODUCTVALIDENDDATE            : String(8);
    ASSORTMENTLISTTYPE             : String;
    HASTEXTILEPARTSWTHANIMALORIGIN : String;
    PRODUCTSEASONUSAGECATEGORY     : String;
    INDUSTRYSECTOR                 : String;
    CHANGENUMBER                   : String;
    MATERIALREVISIONLEVEL          : String;
    ISACTIVEENTITY                 : String;
    LASTCHANGEDATETIME             : Decimal(21, 7);
    LASTCHANGETIME                 : String(6);
    DANGEROUSGOODSINDPROFILE       : String(3);
    PRODUCTUUID                    : Binary(16);
    PRODSUPCHNMGMTUUID22           : String(22);
    PRODUCTDOCUMENTCHANGENUMBER    : String(6);
    PRODUCTDOCUMENTPAGECOUNT       : String(3);
    PRODUCTDOCUMENTPAGENUMBER      : String(3);
    OWNINVENTORYMANAGEDPRODUCT     : String(40);
    DOCUMENTISCREATEDBYCAD         : String;
    PRODUCTIONORINSPECTIONMEMOTXT  : String(18);
    PRODUCTIONMEMOPAGEFORMAT       : String(4);
    GLOBALTRADEITEMNUMBERVARIANT   : String(2);
    PRODUCTISHIGHLYVISCOUS         : String;
    TRANSPORTISINBULK              : String;
    PRODALLOCDETNPROCEDURE         : String(18);
    PRODEFFCTYPARAMVALSAREASSIGNED : String;
    PRODISENVIRONMENTALLYRELEVANT  : String;
    LABORATORYORDESIGNOFFICE       : String(3);
    PACKAGINGMATERIALGROUP         : String(4);
    PRODUCTISLOCKED                : String;
    DISCOUNTINKINDELIGIBILITY      : String;
    SMARTFORMNAME                  : String(30);
    PACKINGREFERENCEPRODUCT        : String(40);
    BASICMATERIAL                  : String(48);
    PRODUCTDOCUMENTNUMBER          : String(22);
    PRODUCTDOCUMENTVERSION         : String(2);
    PRODUCTDOCUMENTTYPE            : String(3);
    PRODUCTDOCUMENTPAGEFORMAT      : String(4);
    PRODUCTCONFIGURATION           : String(18);
    SEGMENTATIONSTRATEGY           : String(8);
    SEGMENTATIONISRELEVANT         : String;
    PRODUCTCOMPOSITIONISRELEVANT   : String;
    ISCHEMICALCOMPLIANCERELEVANT   : String;
    MANUFACTURERBOOKPARTNUMBER     : String(40);
    LOGISTICALPRODUCTCATEGORY      : String;
    SALESPRODUCT                   : String(40);
    PRODCHARC1INTERNALNUMBER       : String(10);
    PRODCHARC2INTERNALNUMBER       : String(10);
    PRODCHARC3INTERNALNUMBER       : String(10);
    PRODUCTCHARACTERISTIC1         : String(18);
    PRODUCTCHARACTERISTIC2         : String(18);
    PRODUCTCHARACTERISTIC3         : String(18);
    MAINTENANCESTATUS              : String(15);
    FASHIONPRODINFORMATIONFIELD1   : String(10);
    FASHIONPRODINFORMATIONFIELD2   : String(10);
    FASHIONPRODINFORMATIONFIELD3   : String(6);
    DFSAMMUNITIONGROUPCODE         : String(8);
    DFSRICIDENTIFIER               : Integer;
    DFSPRODUCTSENSITIVITY          : String(4);
    DFSMANUFACTURERPARTLONGNUMBER  : String(60);
    DFSMATLCONDITIONMGMT           : String;
    DFSRETURNDELIVERY              : String;
    DFSLOGISTICSLEVEL              : String;
    DFSNATIONALITEMIDNNUMBER       : String(9);
    LSTMIPRODUCTTOLERANCETYPE      : String(4);
    ZZPRODUCTHIERARCHY             : String(18);
    ZZPRODUCTFRUITTYPE             : String;
    ZZPRODUCTORIGIN                : String(2);
    ZZPRODUCTFRUITGROUP            : String(5);
    ZZPRODUCTVARIETY               : String(2);
    ZZPRODUCTCLASS                 : String;
    ZZPRODUCTGROWINGMETHOD         : String(2);
    ZZPRODUCTFRUITSIZE             : String(2);
    ZZPRODUCTBRAND                 : String(70);
    ZZPACKSTYLE                    : String(70);
    ZZPRODUCTEXCEPTIONS            : String(70);
    ZZPRODUCTFRUITLABEL            : String(70);
    ZZPRODUCTINNERPACK             : String(70);
    ZZPRODUCTINNERPACKCONTENTS     : String(70);
    ZZPRODUCTINNERPACKLABEL        : String(70);
    ZZPRODUCTMARKETINGMATERIAL     : String(70);
    ZZPRODUCTOUTERPACK             : String(70);
    ZZPRODUCTOUTERPACKCONTENTS     : String(70);
    ZZPRODUCTOUTERPACKLABEL        : String(70);
    ZZPRODUCTNETTWEIGHTMAX         : String(70);
    ZZPRODUCTNETTWEIGHTMIN         : String(70);
    ZZPRODUCTSUBFAMILY             : String(70);
    ZZPRODUCTPALLETBASE            : String(70);
    ZZPRODUCTSTACKINGCONFIG        : String(70);
    ZZREPLACESMATERIAL             : String(40);
    ZZREPLACESMATERIALUOM          : String(3);
    ZZREPLACESMATERIALFROMDATE     : String(8);
    assoc_uom                      : Association to V_IUNITOFMEASURE
                                         on assoc_uom.MANDT = MANDT;
    assoc_businesspartners         : Association to V_IBUSINESSPARTNER
                                         on assoc_businesspartners.MANDT = MANDT;
}

@cds.persistence.exists
entity V_IUNITOFMEASURE {
    MANDT                         : String(3);
    UNITOFMEASURE                 : String(3);
    UNITOFMEASURESAPCODE          : String(3);
    UNITOFMEASUREISOCODE          : String(3);
    ISPRIMARYUNITFORISOCODE       : String;
    UNITOFMEASURENUMBEROFDecimalS : Integer;
    UNITOFMEASUREISCOMMERCIAL     : String;
    UNITOFMEASUREDIMENSION        : String(6);
    SIUNITCNVRSNRATENUMERATOR     : Integer;
    SIUNITCNVRSNRATEDENOMINATOR   : Integer;
    SIUNITCNVRSNRATEEXPONENT      : Integer;
    SIUNITCNVRSNADDITIVEVALUE     : Decimal(9, 6);
    UNITOFMEASUREDSPEXPONENT      : Integer;
    UNITOFMEASUREDSPNMBROFDCMLS   : Integer;
    UNITOFMEASURETEMPERATURE      : Integer;
    UNITOFMEASURETEMPERATUREUNIT  : String(3);
    UNITOFMEASUREPRESSURE         : Integer;
    UNITOFMEASUREPRESSUREUNIT     : String(3);
    UNITOFMEASURE_E               : String(3);
}

@cds.persistence.exists
entity V_IBUSINESSPARTNER {
    MANDT                          : String(3);
    BUSINESSPARTNER                : String(10);
    BUSINESSPARTNERCATEGORY        : String;
    AUTHORIZATIONGROUP             : String(4);
    BUSINESSPARTNERUUID            : Binary(16);
    PERSONNUMBER                   : String(10);
    ETAG                           : String(26);
    BUSINESSPARTNERNAME            : String(81);
    BUSINESSPARTNERFULLNAME        : String(81);
    CREATEDBYUSER                  : String(12);
    CREATIONDATE                   : String(8);
    CREATIONTIME                   : String(6);
    LASTCHANGEDBYUSER              : String(12);
    LASTCHANGEDATE                 : String(8);
    LASTCHANGETIME                 : String(6);
    BUSINESSPARTNERISBLOCKED       : String;
    ISBUSINESSPURPOSECOMPLETED     : String;
    FIRSTNAME                      : String(40);
    LASTNAME                       : String(40);
    PERSONFULLNAME                 : String(80);
    ORGANIZATIONBPNAME1            : String(40);
    ORGANIZATIONBPNAME2            : String(40);
    ORGANIZATIONBPNAME3            : String(40);
    ORGANIZATIONBPNAME4            : String(40);
    INTERNATIONALLOCATIONNUMBER1   : String(7);
    INTERNATIONALLOCATIONNUMBER2   : String(5);
    INTERNATIONALLOCATIONNUMBER3   : String;
    LEGALFORM                      : String(2);
    ORGANIZATIONFOUNDATIONDATE     : String(8);
    ORGANIZATIONLIQUIDATIONDATE    : String(8);
    INDUSTRY                       : String(10);
    ISNATURALPERSON                : String;
    ISFEMALE                       : String;
    ISMALE                         : String;
    ISSEXUNKNOWN                   : String;
    FORMOFADDRESS                  : String(4);
    ACADEMICTITLE                  : String(4);
    ACADEMICTITLE2                 : String(4);
    NAMEFORMAT                     : String(2);
    NAMECOUNTRY                    : String(3);
    BUSINESSPARTNERGROUPING        : String(4);
    BUSINESSPARTNERTYPE            : String(4);
    MIDDLENAME                     : String(40);
    ADDITIONALLASTNAME             : String(40);
    GROUPBUSINESSPARTNERNAME1      : String(40);
    GROUPBUSINESSPARTNERNAME2      : String(40);
    CORRESPONDENCELANGUAGE         : String;
    LANGUAGE                       : String;
    SEARCHTERM1                    : String(20);
    SEARCHTERM2                    : String(20);
    BPLASTNAMESEARCHHELP           : String(35);
    BPFIRSTNAMESEARCHHELP          : String(35);
    BUSINESSPARTNERNICKNAMELABEL   : String(40);
    INDEPENDENTADDRESSID           : String(10);
    ISACTIVEENTITY                 : String;
    BIRTHDATE                      : String(8);
    ISMARKEDFORARCHIVING           : String;
    CONTACTPERMISSION              : String;
    BUSINESSPARTNERIDBYEXTSYSTEM   : String(20);
    LEGALENTITYOFORGANIZATION      : String(2);
    BUSINESSPARTNERPRINTFORMAT     : String;
    BUSINESSPARTNERDATAORIGINTYPE  : String(4);
    BUSINESSPARTNERISNOTRELEASED   : String;
    ISNOTCONTRACTUALLYCAPABLE      : String;
    BUSINESSPARTNEROCCUPATION      : String(4);
    BUSPARTMARITALSTATUS           : String;
    BUSPARTNATIONALITY             : String(3);
    NONRESIDENTCOMPANYORIGINCNTRY  : String(3);
    BUSINESSPARTNERSALUTATION      : String(50);
    BUSINESSPARTNERBIRTHNAME       : String(40);
    BUSINESSPARTNERSUPPLEMENTNAME  : String(4);
    BUSINESSPARTNERBIRTHPLACENAME  : String(40);
    NATURALPERSONEMPLOYERNAME      : String(35);
    BUSINESSPARTNERDEATHDATE       : String(8);
    BUSINESSPARTNERBIRTHDATESTATUS : String;
    BUSINESSPARTNERGROUPTYPE       : String(4);
    LASTNAMEPREFIX                 : String(4);
    LASTNAMESECONDPREFIX           : String(4);
    INITIALS                       : String(10);
    GENDERCODENAME                 : String;
    DATACONTROLLERSET              : String;
    DATACONTROLLER1                : String(30);
    DATACONTROLLER2                : String(30);
    DATACONTROLLER3                : String(30);
    DATACONTROLLER4                : String(30);
    DATACONTROLLER5                : String(30);
    DATACONTROLLER6                : String(30);
    DATACONTROLLER7                : String(30);
    DATACONTROLLER8                : String(30);
    DATACONTROLLER9                : String(30);
    DATACONTROLLER10               : String(30);
    BPDATACONTROLLERISNOTREQUIRED  : String;
    TRDCMPLNCLICENSEISMILITARYSCTR : String;
    TRDCMPLNCLICENSEISNUCLEARSCTR  : String;
}

@cds.persistence.exists
entity V_USR01 {
    key mandt         : String(3);
    key bname         : String(12);
        stcod         : String(20);
        spld          : String(4);
        splg          : String(1);
        spdb          : String(1);
        spda          : String(1);
        datfm         : String(1);
        dcpfm         : String(1);
        hdest         : String(8);
        hmand         : String(3);
        hname         : String(12);
        menon         : String(1);
        menue         : String(20);
        strtt         : String(20);
        langu         : String(1);
        cattkennz     : String(1);
        timefm        : String(1);
        ianatzonecode : String(4);
        assoc_usr02   : Association to V_USR02
                            on  assoc_usr02.mandt = mandt
                            and assoc_usr02.bname = bname;
        assoc_usr03   : Association to V_USR03
                            on  assoc_usr03.mandt = mandt
                            and assoc_usr03.bname = bname;
        assoc_usr04   : Association to V_USR04
                            on  assoc_usr04.mandt = mandt
                            and assoc_usr04.bname = bname;
        assoc_usr05   : Association to V_USR05
                            on  assoc_usr05.mandt = mandt
                            and assoc_usr05.bname = bname;
        profiles      : Association to profiles
                            on profiles.user = $self;
}

@cds.persistence.exists
entity V_USR02 {
    key mandt           : String(3);
    key bname           : String(12);
        bcode           : Binary(8);
        gltgv           : String(8);
        gltgb           : String(8);
        ustyp           : String(1);
        class           : String(12);
        locnt           : Integer;
        uflag           : Integer;
        accnt           : String(12);
        aname           : String(12);
        erdat           : String(8);
        trdat           : String(8);
        ltime           : String(6);
        ocod1           : Binary(8);
        bcda1           : String(8);
        codv1           : String(1);
        ocod2           : Binary(8);
        bcda2           : String(8);
        codv2           : String(1);
        ocod3           : Binary(8);
        bcda3           : String(8);
        codv3           : String(1);
        ocod4           : Binary(8);
        bcda4           : String(8);
        codv4           : String(1);
        ocod5           : Binary(8);
        bcda5           : String(8);
        codv5           : String(1);
        versn           : String(3);
        codvn           : String(1);
        tzone           : String(6);
        zbvmaster       : String(1);
        passcode        : Binary(20);
        pwdchgdate      : String(8);
        pwdstate        : Integer;
        reserved        : Integer;
        pwdhistory      : Integer;
        pwdlgndate      : String(8);
        pwdsetdate      : String(8);
        pwdinitial      : Integer;
        pwdlockdate     : String(8);
        pwdsaltedhash   : String(255);
        security_policy : String(40);
        assoc_usr01     : Association to V_USR02
                              on  assoc_usr01.mandt = mandt
                              and assoc_usr01.bname = bname;
        assoc_usr03     : Association to V_USR03
                              on  assoc_usr03.mandt = mandt
                              and assoc_usr03.bname = bname;
        assoc_usr04     : Association to V_USR04
                              on  assoc_usr04.mandt = mandt
                              and assoc_usr04.bname = bname;
        assoc_usr05     : Association to V_USR05
                              on  assoc_usr05.mandt = mandt
                              and assoc_usr05.bname = bname;
}

@cds.persistence.exists
entity V_USR03 {
    key mandt       : String(3);
    key bname       : String(12);
        name1       : String(30);
        name2       : String(30);
        name3       : String(30);
        name4       : String(30);
        salut       : String(15);
        abtlg       : String(12);
        kostl       : String(8);
        buinr       : String(6);
        roonr       : String(6);
        stras       : String(30);
        pfach       : String(10);
        pstlz       : String(10);
        ort01       : String(25);
        regio       : String(3);
        land1       : String(3);
        spras       : String(1);
        telpr       : String(16);
        telnr       : String(16);
        tel01       : String(5);
        tel02       : String(5);
        telx1       : String(30);
        telfx       : String(31);
        teltx       : String(30);
        ort02       : String(25);
        pstl2       : String(10);
        tzone       : String(6);
        assoc_usr01 : Association to V_USR02
                          on  assoc_usr01.mandt = mandt
                          and assoc_usr01.bname = bname;
        assoc_usr02 : Association to V_USR03
                          on  assoc_usr02.mandt = mandt
                          and assoc_usr02.bname = bname;
        assoc_usr04 : Association to V_USR04
                          on  assoc_usr04.mandt = mandt
                          and assoc_usr04.bname = bname;
        assoc_usr05 : Association to V_USR05
                          on  assoc_usr05.mandt = mandt
                          and assoc_usr05.bname = bname;
}

@cds.persistence.exists
entity V_USR04 {
    key mandt       : String(3);
    key bname       : String(12);
        modda       : String(8);
        modti       : String(6);
        modbe       : String(12);
        nrpro       : Integer;
        profs       : String(3750);
        assoc_usr01 : Association to V_USR02
                          on  assoc_usr01.mandt = mandt
                          and assoc_usr01.bname = bname;
        assoc_usr02 : Association to V_USR03
                          on  assoc_usr02.mandt = mandt
                          and assoc_usr02.bname = bname;
        assoc_usr03 : Association to V_USR04
                          on  assoc_usr03.mandt = mandt
                          and assoc_usr03.bname = bname;
        assoc_usr05 : Association to V_USR05
                          on  assoc_usr05.mandt = mandt
                          and assoc_usr05.bname = bname;
}

@cds.persistence.exists
entity V_USR05 {
    key mandt       : String(3);
    key bname       : String(12);
    key parid       : String(29);
        parva       : String(40);
        assoc_usr01 : Association to V_USR02
                          on  assoc_usr01.mandt = mandt
                          and assoc_usr01.bname = bname;
        assoc_usr02 : Association to V_USR03
                          on  assoc_usr02.mandt = mandt
                          and assoc_usr02.bname = bname;
        assoc_usr03 : Association to V_USR04
                          on  assoc_usr03.mandt = mandt
                          and assoc_usr03.bname = bname;
        assoc_usr04 : Association to V_USR04
                          on  assoc_usr04.mandt = mandt
                          and assoc_usr04.bname = bname;
}

entity profiles : managed {
    key profileId  : UUID;
        user       : Association to V_USR01;
        name       : String(255);
        role       : String(20);
        department : String(50);
        active     : Boolean;
        login_logs : Association to many login_logs
                         on login_logs.profiles = $self;
}

entity login_logs : managed {
    key logId     : UUID;
        profileId : UUID; // for JOIN
        profiles  : Association to profiles;
        loginTime : Timestamp;
        ipAddress : String(45);
        device    : String(100);
        success   : Boolean;
}
