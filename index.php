<html>
	<head>
		<link rel="stylesheet" type="text/css" href="style.css">		
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
		<script src="js/jquery.form-validator.min.js" type="text/javascript"></script>		
	</head>
	<body>
		<div class="header" >Local Environments Manager</div>
		<div class="container">
			<form action="main.php" method="POST" id="envsmanager">
				<table class="container-table">
					<tr>
						<th></th>
						<th></th>
					</tr>
					<tr>						
						<td class="row-right purpose" colspan="2">
							<input type="radio" name="data[input-type-b2b]" class="radio-button b2b-exten"  value="type-b2b" checked="checked"/><span>B2B Extensions</span>
						    <input type="radio" name="data[input-type-other]" class="radio-button other-env" vlaue="type-other"/><span>Other Environments</span>
						</td>
					</tr>
					<tr>
						<td class="row-left">Name</td>
						<td class="row-right"> 
							<input name="data[input-ext-name]" id="input-name" type="text"  data-validation="custom" data-validation-regexp="^[a-z0-9\-]*$"  data-validation-error-msg="Only lowercase letters,numbers and dashes are allowed!" required="required">
						</td>
					</tr>
					<tr>
						<td class="row-left">Included Environments</td>
						<td class="row-right">
							<div class="parent development"><input class="checkbox-parent controller01" type="checkbox" name="development" value="development" data-target=".controlled01" ><span>Development</span></div>
								<div class="children versions developemnt-env">	
									<input name="data[input-dev-mage1702]" class="checkbox-child controlled01" type="checkbox" value="development-1702"/><span>Magento 1.7.2.0</span></br>
									<input name="data[input-dev-mage1800]" class="checkbox-child controlled01" type="checkbox" value="development-1800"/><span>Magento 1.8.0.0</span></br>
									<input name="data[input-dev-mage1810]" class="checkbox-child controlled01" type="checkbox" value="development-1810"/><span>Magento 1.8.1.0</span></br>
									<input name="data[input-dev-mage1901]" class="checkbox-child controlled01" type="checkbox" value="development-1901"/><span>Magento 1.9.0.1</span></br>
									<input name="data[input-dev-mage1910]" class="checkbox-child controlled01" type="checkbox" value="development-1910"/><span>Magento 1.9.1.0</span></br>
									<input name="data[input-dev-mage1920]" class="checkbox-child controlled01" type="checkbox" value="development-1920"/><span>Magento 1.9.2.0</span></br>
							    </div>
							<div class="parent test"><input name="" class="checkbox-parent controller02" type="checkbox" name="environments" value="test" data-target=".controlled02" ><span>Test</span></div>
								<div class="children versions test">	
									<input name="data[input-test-mage1720]" class="checkbox-child controlled02" type="checkbox" value="test-1702"/><span>Magento 1.7.2.0</span></br>
									<input name="data[input-test-mage1800]" class="checkbox-child controlled02" type="checkbox" value="test-1800"/><span>Magento 1.8.0.0</span></br>
									<input name="data[input-test-mage1810]" class="checkbox-child controlled02" type="checkbox" value="test-1810"/><span>Magento 1.8.1.0</span></br>
									<input name="data[input-test-mage1901]" class="checkbox-child controlled02" type="checkbox" value="test-1901"/><span>Magento 1.9.0.1</span></br>
									<input name="data[input-test-mage1910]" class="checkbox-child controlled02" type="checkbox" value="test-1910"/><span>Magento 1.9.1.0</span></br>
									<input name="data[input-test-mage1920]" class="checkbox-child controlled02" type="checkbox" value="test-1920"/><span>Magento 1.9.2.0</span></br>
							    </div>
							<div class="github">
								<input name="data[input-github-incl]" class="checkbox-parent" type="checkbox" name="environments" value="github" ><span>Github</span>
							</div>
						</td>
					</tr>
					<tr>
						<td class="row-left">Use Demo Data</td>
						<td class="row-right">
							<select name="data[input-usedemodata]" >
								<option>No</option>
								<option>Yes</option>
							</select>
						</td>
					</tr>
					<tr>
						<td class="row-left">Your Email Address</td>
						<td class="row-right">
							<input name="data[input-emailaddr]" id="input-email" type="email" data-validation-error-msg="This is an email field" required="required"/>
						</td>
					</tr>
					<tr>
						<td></td>
						<td class="row-right"><input class="button-insert" type="submit" value="Create"/></td>
					</tr>
				</table>
			</form>
			<div id='envs-grid'>
				<table class='grid-table' >
					<tr>
						<th>Name</th>
						<th>Domain</th>
						<th>View Subdomains</th>
						<th>User</th>
						<th>Action</th>
					</tr>
				</table>
				
					
			</div>
			
		</div>
		<div class="footer"><span>&copy; Copyright</span></div>
	</body>
	<script type="text/javascript">
	
		

		$(function() {
			$.ajax({
				url: "grid.php",
				type: "POST",
				cache: false,
				async: false,
				dataType: "json",
				data: {
					'data':'read'
				},
				success: function(msg) {
					//console.log(JSON.stringify(msg.elements));
					var count = 0;
					$.each(msg.elements, function(idx, element){
						
						
						count = count + 1;
						$(".grid-table").append('<tr><td style="display: none"><a id="element-db-id-' + count + '" >' + element.id + '</a></td>'
												+ '<td><a id="element-name-' + count + '">' + element.name + '</a></td>'
												+ '<td><a id="element-domain-' + count + '">' + element.domain + '</a></td>'
												+ '<td class="sub-domains"><a id="element-subdomain-'+ count + '" onclick="subDomainAction('+count+')"><span>+</span></a></td>'
												+ '<td><a id="element-useremail-' + count + '">' + element.user_email + '</a></td>'
												+ '<td class="remove-action"><input id="remove-button" type="submit" onclick="removeAction(' + count + ');" value="Remove" ></td></tr>');
					});
				}
			});
		});
function subDomainAction(count){
  $(function(){
	  $.ajax({
		  url: "grid.php",
			type: "POST",
			cache: false,
			async: false,
			dataType: "json",
			data: {
				'data_sub':'read'
			},
			success: function(msg) {
				//console.log(JSON.stringify(msg.elements));
				var count = 0;	
				$.each(msg.subelements, function(idx, subelements){					
					count = count + 1;
					$(".grid-table tr.second-row td").append('<table><tr><th>Name</th><th>Domain</th><th>Action</th></tr><tr><td style="display: none"><a id="element-db-id-' + count + '" >' + subelements.id + '</a></td>'
											+ '<td><a id="element-name-' + count + '">' + subelements.name + '</a></td>'
											+ '<td><a id="element-domain-' + count + '">' + subelements.domain + '</a></td>'																			
											+ '<td class="remove-action"><input id="remove-button" type="submit" onclick="removeAction(' + count + ');" value="Remove" ></td></tr></table>');
				});
			}
		  
	  });
  });
		
}		
		
		function removeAction(count, name) {
				
			var elementDbId = $("#element-db-id-" + count).text();
			var elementName = $("#element-name-" + count).text();
			
			if (confirm('Are you sure to remove ' + elementName + ' and all subenvironments?')) {
				$.ajax({
					url: "grid.php",
					type: "POST",
					cache: false,
					async: false,
					dataType: "json",
					data: {
						'remove':1,
						'id':elementDbId
					},
					success: function(msg) {
						console.log(JSON.stringify(msg.error));
					}
				});   
			} else {
				// Do nothing!
			}

		}
		
		$("#input-name").keyup(function() {
			$('#label-domain').text($(this).val());
		});

		$("#input-name").keyup(function() {
			$('#label-path').text($(this).val());
		});

		$(".button-insert").click(function() {

			var name = $("#input-name").val();
			
			$.ajax({
				url: "main.php",
				type: "POST",
				cache: false,
				async: false,
				dataType: "json",
				data: {
					'name':name
				},
				success: function(msg) {
					console.log(msg);
				}
				
			});   

			if($('.parent.development input[type="checkbox"').is(':checked')){
				  if(!$('.developemnt-env input[type="checkbox"]').is(':checked')){
			        return false;
				    }
	            }

	            if($('.parent.test input[type="checkbox"').is(':checked')){
	  			  if(!$('.children.versions.test input[type="checkbox"]').is(':checked')){
	  			      return false;
	  			    }
	              }		                   
            
		});
		

		$('.checkbox-child').prop('disabled', true);
		$('.checkbox-parent').click(function () {
		    var $this = $(this),
		        $inputs = $($this.data('target'));

		    $inputs.prop('disabled', !this.checked);
		    if (!this.checked) {
		        $inputs.prop('checked', false);
		    }
		});
		
		
		//****** Validation **********//	
			
		$.validate(); 
		$('#envsmanager').get(0).reset();		

		 $('.parent.test input[type="checkbox"]').change(function() {
			 if($('.parent.test input[type="checkbox"]').is(':checked')){
				 
			 if(!$('.children.versions.test input[type="checkbox"]').is(':checked')){
	  				var html2= '<p class="help-block form-error test-error">You must select at least one!</p>';
	  			      $('.children.versions.test').append(html2);
	  			     return false;
	  			  }
			 }else{
				 $('.test-error').hide();
			 }
		 });


	      $('.parent.development input[type="checkbox"]').change(function(){
	    	if($('.parent.development input[type="checkbox"]').is(':checked')){		
		    	    	
			  if(!$('.developemnt-env input[type="checkbox"]').is(':checked')){
				  var html= '<p class="help-block form-error dev-error">You must select at least one!</p>';				 
			      $('.children.versions.developemnt-env').append(html);
			        return false;			        
			 	}
	    	 }else{
	    		$('.dev-error').hide();
		     }
          });
	    //****** End Validation **********//
	    

	      $('input[type=radio]').change(function() {    	           
	           $('input[type=radio]:checked').not(this).prop('checked', false);
	           if ($(this).attr("checked") == "checked") {
	              $('.parent.test').show();
	              $('.children.versions.test').show();
	              $('.github').show();
	           }else{
	        	   $('.parent.test').hide();
	        	   $('.children.versions.test').hide();
	        	   $('.github').hide();
		        }
	      });
	      
	</script>
</html>
