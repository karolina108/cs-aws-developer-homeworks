
API_URL = "https://2ta9dxbvb2.execute-api.eu-west-1.amazonaws.com/Prod/register/";

postRequest = function() {

    $("#response").text("");
    data = {
        "person" : {
            "email" : $("#emailInput").val(),
            "name" : $("#nameInput").val()
        }
    }

    fetch(API_URL, {
        method: 'post',
        body: JSON.stringify(data),
        headers: {
            "Content-type": "application/json; charset=UTF-8"
        }
    }).then(res => {
        if (res.status === 200 || res.status === 400) return res.json()
    }).then(json => {
        $("#response").text(JSON.stringify(json, null, 4));
    }).catch(error => $("#response").text(error));
}