function rating2Corlor(rating){
    var corlor = "";
    switch (rating)
    {
        case "0":
            corlor = "badge-success"
            break;
        case "1":
            corlor = "badge-info"
            break;
        case "2":
            corlor = "badge-info"
            break;
        case "3":
            corlor = "badge-yellow"
            break;
        case "4":
            corlor = "badge-warning"
            break;
        case "5":
            corlor = "badge-danger"
            break;
        default:
            corlor = ""
            break;
    }
    return corlor;
}