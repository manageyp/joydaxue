$(document).ready(function(){
	//可售票种高度
	$('#scrollbar').height($(window).height()-490)
	
	$('.datetimepicker').datetimepicker({
		format: 'yyyy-mm-dd hh:ii:ss',
		autoclose: true,
		endDate: '+5d'
	})

	var trI = 0,inputI = 0;
	
	//input框 数字的加减方法
	function selectInput(o){
		var obj = $('#selector1 input:focus');
		var value = obj.val();
		if(o!=2){
			if(o==0){
				if(value>0){
					value--;
				}
			}else{
				value++;
			}
		}
		obj.val(value);
		var s = $('#selector1').find('.selected');
		var val = s.find('.input1').val();
		var tal = s.find('.input2').val();
		if(val==0 || tal == 0){
			s.removeClass('active');
			delTicket(s);
		}else{
			s.addClass('active');
			addTicket(s);
		}
	}
	
	//input 内容改变事件
	$.event.special.inputchange = {
		setup: function() {
			var self = this, val;
			$.data(this, 'timer', window.setInterval(function() {
				val = self.value;
				if ( $.data( self, 'cache') != val ) {
					$.data( self, 'cache', val );
					$( self ).trigger( 'inputchange' );
				}
			}, 200));
		},
		teardown: function() {
			window.clearInterval( $.data(this, 'timer') );
		},
		add: function() {
			$.data(this, 'cache', this.value);
		}
	};
	
	$(document).keydown(function(e){
		var obj = $('#selector1 tbody tr');
		var trNum = obj.length;

		//票tr 的加减
		function selectTr(o){
			o==0 ? trI-- : trI++;
			obj.removeClass('selected').eq(trI % trNum).addClass('selected').find('.input1').focus();
			inputI = 1;
		}
		


		//up 键
		if (e.keyCode == 38){
			selectTr(0);
			return false;
		}

		//down 键
		if (e.keyCode == 40){
			selectTr(1);
			return false;
		}

		//left键
		if (e.keyCode == 37){
			selectInput(0);
			return false;
		}

		//right 键
		if (e.keyCode == 39){
			selectInput(1);
			return false;
		}
		//Tab 键
		if (e.keyCode == 9){
			$('#selector1').find('.selected input').eq(inputI++%2).focus();
			return false;
		}

		//回车键
		if (e.keyCode == 13){
			var i = $('[tabIndex]:focus').attr('tabIndex');
			if(i){
				$('[tabIndex="'+(parseInt(i)+1)+'"]').focus()
			}else{
				$('[tabIndex="1"]').focus()
			}
			return false;
		}
	});

	//鼠标加
	$('.spinner-down-s').click(function(){
		$('#selector1 tbody tr').removeClass('selected')
		$(this).parents('tr').addClass('selected')
		$(this).parents('.spinner').find('input').focus()
		selectInput(0)
	})
	
	//鼠标减
	$('.spinner-up-s').click(function(){
		$('#selector1 tbody tr').removeClass('selected')
		$(this).parents('tr').addClass('selected')
		$(this).parents('.spinner').find('input').focus()
		selectInput(1)
	})

	//input 输入
	$('.spinner-input').on('inputchange', function(){
		$('#selector1 tbody tr').removeClass('selected')
		$(this).parents('tr').addClass('selected')
		selectInput(2)
		$(this).val($(this).val().replace(/[^\d]/g,''))
	})
	
	$('select').keydown(function(e){
		if (e.keyCode == 38||e.keyCode == 40){
			e.stopPropagation()
		}
	})
	
	
	
	//鼠标放上事件
	$('.ticket_name').find('label').hover(function(){
		$(this).trigger('click');
	},function(){
		$(this).trigger('click');
	});

	$('#print').keydown(function(e){
		if (e.keyCode == 13){
			$(this).addClass('active');
			$(this).trigger('click');
		}
		return false;
	});

	//计算数量和价格
	var calcNumPri = function(){
		var selectedTr = $('#selector1').find('.active');
		//订单数量
		var orderNum   = 0;
		//价格
		var totalPri   = 0;
		selectedTr.each(function(){
			var curOrder = parseInt($(this).find('.input1').val());
			var curTicket= parseInt($(this).find('.input2').val());
			var curPrice = parseInt($(this).find('.price').html());
			orderNum += curOrder;
			totalPri += curPrice*curOrder*curTicket;
		});
		$('#total_order_number').html(orderNum);
		$('#total_price').html(totalPri);
		receipt_fun();
	}

	// 添加
	function addTicket(obj)
	{
		$('#ticket_select').find($('#ticket_msg')).remove();
		var id = obj.attr('tid');
		// 添加票
		var name = $("#name_" + id).html();
		var price = parseInt($("#price_" + id).html());
		var ticket_number = $("#ticket_number_" + id).val();
		var order_number = $("#order_number_" + id).val();
		var expire_time = $("#expire_time_" + id).val();
		var order_total_price = price * ticket_number * order_number;
		var input_value = id + "," + order_number + "," + ticket_number + "," + expire_time;
		var input_html = "<input type=\"hidden\" name=\"ticket[]\" id=\"ticket_" + id + "\" value=\"" + input_value + "\">";
		if ($("#ticket_" + id).length > 0) {
			delTicket(obj);
		}
		$("#hidden_ticket").append(input_html);
		calcNumPri();
	}

	// 移除
	function delTicket(obj)
	{
		var id      = obj.attr('tid');
		$("#ticket_"+id).remove();
		calcNumPri();
	}


	$('#form').validationEngine({
		promptPosition : 'topLeft',
		addFailureCssClassToField: 'error',
		showPrompts: false
	});

});

//预打印票
function tryPrintTicket(data) {
	var tryPrintObj = $('#try_print_ticket');
	tryPrintObj.find('.qr img').attr('src', data.qrcode);
	tryPrintObj.find('.qr p').html(data.code);
	// tryPrintObj.find('.info h2').html(data.ticket_type);
	if (data.name) {
		tryPrintObj.find('.info h2').html(data.ticket_type + "(" + data.name + ")");
	} else {
		tryPrintObj.find('.info h2').html(data.ticket_type);
	}
	tryPrintObj.find('.info div').html(data.ticket_number + ' 张');
	// tryPrintObj.find('.info p').html("2014-03-11 16:03:40");
	tryPrintObj.find('.info p').html("失效时间:<br/>" + data.expireTime);
	tryPrintObj.find('.main').clone().appendTo($('#HL-QR'));
}

//删除已选票信息
function deleteSelect() {
	var selectedTr = $('#selector1').find('.active');
	selectedTr.each(function(){
		$(this).find('.input1').val(0);
		$(this).find('.input2').val(1);
		$(this).removeClass('active');
	});
	$("#hidden_ticket").find('input').remove();
	$('#total_price').html(0);
	$('#total_order_number').html(0);
	$('#receipt').val('');
	$('#refund').html(0);
}

// 收款金额
function receipt_fun() {
	var receipt = $("#receipt").val();
	if (isNaN(receipt)) {
		receipt = 0;
		$('#receipt').val('');
	}
	receipt   = parseInt(receipt);
	var price = parseInt($("#total_price").html());
	$("#refund").html(receipt - price);
}