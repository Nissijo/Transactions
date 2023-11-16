Select e.CLP_ClaimPaymentInformation.PayerClaimControlNumber_07 as Claim_ID,
c.N1_PayerIdentification.PremiumPayerName_02 as Payer,
d.N1_PayeeIdentification.IntermediaryBankIdentifier_04 as Payee_bankID,
d.N1_PayeeIdentification.PremiumPayerName_02 as Payee_name,
FROM_UNIXTIME(UNIX_TIMESTAMP(a.Date_4, 'yyyyMMdd'), 'MM/dd/yy') as Paid_date,
f.DTM_ServiceDate[0]as Service_date,
f.SVC_ServicePaymentInformation.CompositeMedicalProcedureIdentifier_01.ProcedureCode_02 as Service_Procedurecode,
f.SVC_ServicePaymentInformation.LineItemChargeAmount_02 as Billed_amt,
f.SVC_ServicePaymentInformation.MonetaryAmount_03 as Paid_amt 
from group_header a join transaction b on a.HeaderID=b.HeaderID join payer c on b.TransactionID=c.TransactionID join payee d 
on c.TransactionID=d.TransactionID join claim_payment_info e on d.TransactionID=e.TransactionID join service_payment_info f 
on e.PaymentID=f.PaymentID where e.CLP_ClaimPaymentInformation.PayerClaimControlNumber_07= {{claim}} 
and (a.paiddate >= '{{ paid.start }}' and a.paiddate <= '{{ paid.end }}');