using {managed} from '@sap/cds/common';

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
