<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Electricity Bill Calculator</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <main class="app-shell">
        <section class="calculator-card">
            <div class="card-header">
                <span class="badge">Smart Utility Estimator</span>
                <h1>Electricity Bill Calculator</h1>
                <p>Enter your electricity usage to calculate the bill using slab-based tariff.</p>
            </div>

            <form id="billForm" class="bill-form" action="result.jsp" method="post">
                <label for="units" class="field-label">Units Consumed</label>
                <div class="input-wrap">
                    <input
                        type="number"
                        id="units"
                        name="units"
                        placeholder="e.g. 150"
                        min="0"
                        step="0.01"
                        required
                    >
                    <span class="unit-suffix">kWh</span>
                </div>

                <div id="validationMessage" class="validation-message" aria-live="polite">
                    <%
                        String message = request.getParameter("msg");
                        if (message != null && !message.isEmpty()) {
                            out.print(message);
                        }
                    %>
                </div>

                <div class="button-group">
                    <button type="submit" class="btn btn-primary">Calculate Bill</button>
                    <button type="button" id="resetBtn" class="btn btn-secondary">Reset</button>
                </div>
            </form>
        </section>
    </main>

    <script src="js/script.js"></script>
</body>
</html>
