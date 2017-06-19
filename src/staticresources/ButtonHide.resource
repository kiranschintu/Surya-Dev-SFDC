alert('Hello');
      var obj1 = document.getElementsByTagName("div");
      for (var j = 0; j < obj1.length; j++){
          if (obj1[j].innerHTML == "<h2>test</h2>" || obj1[j].innerHTML == "<H2>test</H2>"){
              obj1[j].style.display = "none";
          }
      }
      
      var referrerPage = document.referrer;
      alert('Hello1:'+referrerPage);
      if (referrerPage.indexOf("frontdoor") >= 0 || referrerPage.indexOf("contentDoor") >= 0 || (document.referrer == "" && location.href.indexOf  ("loginFlag=false") < 0)){
        alert('Side bar::'+document.getElementById("sidebarCell"));
		  document.getElementById("sidebarCell").style.display = "none";
          document.getElementById("AppBodyHeader").style.display = "none";
          document.body.style.display = "none";
          var query = window.location.search.substring(1);
          alert('Hello2::'+query);
          //if(query != ""){
            //  alert('In If');
              window.location.href= "/apex/TermsAndConditionsResult";
          /*}
          else{
              alert('In if else');
              //window.location= "/home/home.jsp";
          }*/
	}
