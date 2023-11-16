select e.CLP_ClaimPaymentInformation.PayerClaimControlNumber_07 as Claim_ID,
f.DTM_ServiceDate[0]as Service_date,
f.SVC_ServicePaymentInformation.CompositeMedicalProcedureIdentifier_01.ProcedureCode_02 as Service_Procedurecode,
f.CAS_ServiceAdjustment,
f.CAS_ServiceAdjustment.ClaimAdjustmentGroupCode_01,f.CAS_ServiceAdjustment.AdjustmentReasonCode_02,
f.CAS_ServiceAdjustment.AdjustmentAmount_03,f.SVC_ServicePaymentInformation.LineItemChargeAmount_02 as Billed_amt,
f.SVC_ServicePaymentInformation.MonetaryAmount_03 as paid_amt 
from group_header a join transaction b on a.HeaderID=b.HeaderID join payer c on b.TransactionID=c.TransactionID join payee d 
on c.TransactionID=d.TransactionID join claim_payment_info e on d.TransactionID=e.TransactionID join service_payment_info f 
on e.PaymentID=f.PaymentID where e.CLP_ClaimPaymentInformation.PayerClaimControlNumber_07= {{claim}};