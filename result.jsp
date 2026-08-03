<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.text.DecimalFormat" %>

<!DOCTYPE html>

<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

```
<title>Electricity Bill Result</title>

<link rel="stylesheet" href="css/style.css">
```

</head>

<body>

<main class="app-shell">

```
<section class="result-card">

    <div class="card-header">

        <span class="badge">Calculated Summary</span>

        <h1>Electricity Bill Statement</h1>

        <p>
            Your electricity bill has been calculated
            using the slab-based tariff.
        </p>

    </div>

    <%

        /*
         * Get the number of units entered by the user.
         */
        String unitsParam = request.getParameter("units");

        DecimalFormat currencyFormat =
        new DecimalFormat("#,##0.00");

        DecimalFormat quantityFormat =
                new DecimalFormat("0.00");

        double units = 0;
        double totalBill = 0;

        double slab1Units = 0;
        double slab2Units = 0;
        double slab3Units = 0;
        double slab4Units = 0;

        double slab1Cost = 0;
        double slab2Cost = 0;
        double slab3Cost = 0;
        double slab4Cost = 0;

        /*
         * Validate the input.
         */
        if (unitsParam == null || unitsParam.trim().isEmpty()) {

            response.sendRedirect(
                "index.jsp?msg=Please enter the number of units."
            );

            return;
        }

        try {

            units = Double.parseDouble(unitsParam.trim());

            if (units < 0) {

                response.sendRedirect(
                    "index.jsp?msg=Units cannot be negative."
                );

                return;
            }

        } catch (NumberFormatException e) {

            response.sendRedirect(
                "index.jsp?msg=Please enter a valid number."
            );

            return;
        }


        /*
         * ELECTRICITY BILL SLAB CALCULATION
         *
         * First 50 units     = Rs. 3.50/unit
         * Next 100 units     = Rs. 4.00/unit
         * Next 100 units     = Rs. 5.20/unit
         * Above 250 units    = Rs. 6.50/unit
         */

        if (units <= 50) {

            // First slab
            slab1Units = units;
            slab1Cost = slab1Units * 3.50;

        }

        else if (units <= 150) {

            // First 50 units
            slab1Units = 50;
            slab1Cost = 50 * 3.50;

            // Remaining units
            slab2Units = units - 50;
            slab2Cost = slab2Units * 4.00;

        }

        else if (units <= 250) {

            // First 50 units
            slab1Units = 50;
            slab1Cost = 50 * 3.50;

            // Next 100 units
            slab2Units = 100;
            slab2Cost = 100 * 4.00;

            // Remaining units
            slab3Units = units - 150;
            slab3Cost = slab3Units * 5.20;

        }

        else {

            // First 50 units
            slab1Units = 50;
            slab1Cost = 50 * 3.50;

            // Next 100 units
            slab2Units = 100;
            slab2Cost = 100 * 4.00;

            // Next 100 units
            slab3Units = 100;
            slab3Cost = 100 * 5.20;

            // Units above 250
            slab4Units = units - 250;
            slab4Cost = slab4Units * 6.50;

        }

        /*
         * Calculate final bill.
         */
        totalBill =
                slab1Cost +
                slab2Cost +
                slab3Cost +
                slab4Cost;

    %>


    <div class="result-summary">

        <div class="summary-item">

            <span>Units Consumed</span>

            <strong>
                <%= quantityFormat.format(units) %> kWh
            </strong>

        </div>


        <div class="summary-item">

            <span>Total Electricity Bill</span>

            <strong>
                <%= currencyFormat.format(totalBill) %>
            </strong>

        </div>

    </div>


    <div class="table-wrap">

        <table class="bill-table">

            <thead>

                <tr>
                    <th>Slab</th>
                    <th>Units</th>
                    <th>Rate</th>
                    <th>Cost</th>
                </tr>

            </thead>


            <tbody>

                <% if (slab1Units > 0) { %>

                <tr>

                    <td>First 50 Units</td>

                    <td>
                        <%= quantityFormat.format(slab1Units) %>
                    </td>

                    <td>Rs. 3.50</td>

                    <td>
                        <%= currencyFormat.format(slab1Cost) %>
                    </td>

                </tr>

                <% } %>


                <% if (slab2Units > 0) { %>

                <tr>

                    <td>Next 100 Units</td>

                    <td>
                        <%= quantityFormat.format(slab2Units) %>
                    </td>

                    <td>Rs. 4.00</td>

                    <td>
                        <%= currencyFormat.format(slab2Cost) %>
                    </td>

                </tr>

                <% } %>


                <% if (slab3Units > 0) { %>

                <tr>

                    <td>Next 100 Units</td>

                    <td>
                        <%= quantityFormat.format(slab3Units) %>
                    </td>

                    <td>Rs. 5.20</td>

                    <td>
                        <%= currencyFormat.format(slab3Cost) %>
                    </td>

                </tr>

                <% } %>


                <% if (slab4Units > 0) { %>

                <tr>

                    <td>Above 250 Units</td>

                    <td>
                        <%= quantityFormat.format(slab4Units) %>
                    </td>

                    <td>Rs. 6.50</td>

                    <td>
                        <%= currencyFormat.format(slab4Cost) %>
                    </td>

                </tr>

                <% } %>

            </tbody>

        </table>

    </div>


    <div class="result-actions">

        <a href="index.jsp" class="btn btn-primary">
            Calculate Another Bill
        </a>

    </div>

</section>
```

</main>

</body>

</html>
