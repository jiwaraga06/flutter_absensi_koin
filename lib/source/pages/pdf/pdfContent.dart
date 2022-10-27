class PDFVIEW {
  static htmlContent(total, tglAwal, tglAkhir, shopID) {
    return """
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- CSS only -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
    <title>Total Jumlah Koin</title>
</head>

<body>
    <div class="text-center" style=" margin-top: 40px;">
        <h4>Report Transaksi Koin ${shopID}</h4>
        <h5>Periode tanggal ${tglAwal} - ${tglAkhir}</h5>
        <table class="table table-bordered" style="width: 350px; margin-left:auto; margin-right:auto; margin-top: 20px;">
            <thead>
                <tr>
                    <td>Total Jumlah Koin</td>
                </tr>
            </thead>
            <tbody class="">
                <tr>
                    <td>${total}</td>
                </tr>
            </tbody>
        </table>
    </div>
</body>

</html>
""";
  }
}
