# ======================================
# PowerShell Script: kaka.ps1
# Tự động gửi POST request định kỳ
# ======================================

# URL API
$Url = "https://fcc14-uat2.tpb.vn/PMReST/obpmrest/payments/singlepayout/"

# Headers
$Headers = @{
    "Accept" = "*/*"
    "Accept-Encoding" = "gzip, deflate"
    "Cache-Control" = "no-cache"
    "Content-Type" = "application/json"
    "Cookie" = "NSC_gdd14-vbu2.uqc.wo_mcwt_443=ffffffff09c2577f45525d5f4f58455e445a4a42151a"
    "Host" = "fcc14-uat2.tpb.vn"
    "User-Agent" = "PostmanRuntime/7.15.2"
    "entity" = "ENTITY_ID1"
    "hostCode" = "FLEXPROD"
    "password" = "123456"
    "source" = "OBTFBC"
    "userId" = "ADMININPUT10"
}

# JSON Payload
$Body = @{
    txnDet = @{
        txnBranch = "001"
        hostCode = "FLEXPROD"
        sourceCode = "EXTSYS"
        networkCode = "SWIFT"
        prefundedPayments = "N"
        pmtType = "X"
        transferType = "C"
        remarks = "SO TIEN SGD3000,NHL: PCT SGD15.00,DP USD10.00,VAT10%,TG 17000"
        custcrdtrfinitPmtinfDto = @{
            dbtraccothrid = "45994400702"
            dbtraccccy = "VND"
            inputChrgAcBrn = "019"
            inputChrgAcNo = "18198899001"
            inputChrgCcy = "VND"
            chrgbr = "SHA"
            dbtrnm = "FUNIX ONLINE EDUCATION JSC"
            dbtradrline1 = "CGGV"
        }
        custcrdtrfinitCdttxinfDto = @{
            instrid = "FEB001240606031"
            instdamtccy = "SGD"
            instdamt = 317
            cdtragtbicfi = "BOTKJPJTXXX"
            cdtrctry = "JP"
            cdtraccothrid = "/2481314"
            cdtradrline1 = "ADSF"
            rmtinfustrd1 = "/RFB/PAYMENT FOR INTERNAL BALANCE 2"
            rmtinfustrd2 = "022"
            xchgrate = 17000
        }
        custcrdtrfinitAddinfDto = @{
            creditNostro = "00028540001"
            recvr = "UOVBSGSGXXX"
        }
        custcrdtrfinitChgs = @(
            @{
                componentName = "PRC_CHG_C"
                pricingCcy = "SGD"
                amount = "15.00"
                waiver = "N"
                pricingCode = "S_SB_SGD_C"
            },
            @{
                componentName = "VAT_PRC_C"
                pricingCcy = "VND"
                amount = "1.50"
                waiver = "N"
                pricingCode = "S_SB_SGD_C"
            },
            @{
                componentName = "CAB_CHG_C"
                pricingCcy = "USD"
                amount = "10.00"
                waiver = "N"
                pricingCode = "S_SB_SGD_C"
            }
        )
    }
}

# ======================================
# Hàm gửi request
# ======================================
function Send-ApiRequest {
    try {
        $response = Invoke-RestMethod -Uri $Url -Headers $Headers -Method Post -Body ($Body | ConvertTo-Json -Depth 5)
        Write-Host "$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') Gửi thành công!" -ForegroundColor Green
        Write-Output $response
    } catch {
        Write-Host "$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') Lỗi khi gửi request:" -ForegroundColor Red
        Write-Host $_.Exception.Message
    }
}

# ======================================
# Vòng lặp định kỳ
# ======================================
while ($true) {
    Send-ApiRequest
    Start-Sleep -Seconds 300   # 300 giây = 5 phút
}
