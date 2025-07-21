using {
    V_USR01,
    V_USR05,
    profiles,
    login_logs
} from '../db/schema';

service CatalogService @(path: '/catalog') {

    entity view_USR01 as projection on V_USR01;
    entity view_USR05 as projection on V_USR05;
    entity view_profiles as projection on profiles;
    entity view_loginlogs as projection on login_logs;

    function getJoinVirtualData() returns String;
}
