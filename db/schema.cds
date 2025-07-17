using {managed} from '@sap/cds/common';

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
        profiles        : Association to profiles
                              on profiles.user = $self;
}

entity profiles : managed {
    key profileId  : UUID;
        user       : Association to V_USR02;
        name       : String(255);
        role       : String(20);
        department : String(50);
        active     : Boolean;
        login_logs : Association to many login_logs on login_logs.profiles = $self;
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
