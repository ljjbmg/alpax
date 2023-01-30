User Function MA120BUT() 
Local aButtons := {} 
// Bota um add

aadd(aButtons,{'BUDGETY',{|| Alert("Bto1")},'Consulta Aprovacao','Aprovac.'}) 
aadd(aButtons,{ 'NOTE ' ,{|| Alert("Bto2") },'Desconto','Desc' } )

Return (aButtons )
