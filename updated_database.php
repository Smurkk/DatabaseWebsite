<!DOCTYPE html>
<html>
   <head>
      <meta charset="utf-8">
      <title>Search Results</title>
      <style type="text/css">
         body  { font-family: sans-serif; background-color: lightyellow; }
         table { background-color: lightblue; border-collapse: collapse; border: 1px solid gray; }
         td    { padding: 5px; }
         tr:nth-child(odd) { background-color: white; }
         h2    { color: darkblue; }
      </style>
   </head>
   <body>
      <?php
         $action = $_POST["action"];
         $database = mysqli_connect("localhost", "root", "");

         if (!$database) {
            die("Could not connect to database </body></html>");
         }

         if (!mysqli_select_db($database, "RealEstate")) {
            die("Could not open RealEstate database </body></html>");
         }

         switch ($action) {
            case "all_listings":
               echo "<h2>All Listings</h2>";

               //Query for houses
               $houses_query = "
                  SELECT H.address, H.bedrooms, H.bathrooms, P.price 
                  FROM House H 
                  JOIN Property P ON H.address = P.address";
               $houses_result = mysqli_query($database, $houses_query);

               if (!$houses_result) {
                  die("Query for houses failed: " . mysqli_error($database) . " </body></html>");
               }

               echo "<h3>Houses</h3>";
               echo "<table border='1'>";
               echo "<tr><th>Address</th><th>Bedrooms</th><th>Bathrooms</th><th>Price</th></tr>";
               while ($row = mysqli_fetch_assoc($houses_result)) {
                  echo "<tr>";
                  foreach ($row as $value) {
                     echo "<td>" . htmlspecialchars($value) . "</td>";
                  }
                  echo "</tr>";
               }
               echo "</table>";

               //Query for businesses
               $business_query = "
                  SELECT B.address, B.type, B.size, P.price 
                  FROM BusinessProperty B 
                  JOIN Property P ON B.address = P.address";
               $business_result = mysqli_query($database, $business_query);

               if (!$business_result) {
                  die("Query for business properties failed: " . mysqli_error($database) . " </body></html>");
               }

               echo "<h3>Business Properties</h3>";
               echo "<table border='1'>";
               echo "<tr><th>Address</th><th>Type</th><th>Size (sqft)</th><th>Price</th></tr>";
               while ($row = mysqli_fetch_assoc($business_result)) {
                  echo "<tr>";
                  foreach ($row as $value) {
                     echo "<td>" . htmlspecialchars($value) . "</td>";
                  }
                  echo "</tr>";
               }
               echo "</table>";
               break;

            //Query for finding a house based on min and max price along with bedrooms and bathrooms
            case "filter_houses":
               echo "<h2>Filtered Houses</h2>";
               $min_price = $_POST["min_price"];
               $max_price = $_POST["max_price"];
               $bedrooms = $_POST["bedrooms"];
               $bathrooms = $_POST["bathrooms"];
               $query = "
                  SELECT H.address, H.bedrooms, H.bathrooms, P.price
                  FROM House H
                  JOIN Property P ON H.address = P.address
                  WHERE P.price BETWEEN $min_price AND $max_price 
                    AND H.bedrooms >= $bedrooms 
                    AND H.bathrooms >= $bathrooms";
               break;
            //Query for finding business based on min and max price, along with min and max square footage
            case "filter_business":
               echo "<h2>Filtered Business Properties</h2>";
               $min_price = $_POST["min_price"];
               $max_price = $_POST["max_price"];
               $min_size = $_POST["min_size"];
               $max_size = $_POST["max_size"];
               $query = "
                  SELECT B.address, B.type, B.size, P.price
                  FROM BusinessProperty B
                  JOIN Property P ON B.address = P.address
                  WHERE P.price BETWEEN $min_price AND $max_price 
                    AND B.size BETWEEN $min_size AND $max_size";
               break;

            //Selecting all agents
            case "all_agents":
               echo "<h2>All Agents</h2>";
               $query = "SELECT agentId, name, phone, firmId, dateStarted FROM Agent";
               break;

            //Selecting all buyers
            case "all_buyers":
               echo "<h2>All Buyers</h2>";
               $query = "SELECT id, name, phone, propertyType, bedrooms, bathrooms, businessPropertyType, minimumPreferredPrice, maximumPreferredPrice FROM Buyer";
               break;
            
            //Custom query
            case "custom_query":
               echo "<h2>Custom Query Results</h2>";
               $query = $_POST["custom_query"];
               break;

            default:
               die("Invalid action specified.</body></html>");
         }

         if (isset($query)) {
            $result = mysqli_query($database, $query);

            if (!$result) {
               die("Query failed: " . mysqli_error($database) . " </body></html>");
            }

            //Sets up the tables and rows for each query
            echo "<table border='1'>";
            $first_row = true;
            while ($row = mysqli_fetch_assoc($result)) {
               if ($first_row) {
                  echo "<tr>";
                  foreach ($row as $key => $value) {
                     echo "<th>" . htmlspecialchars($key) . "</th>";
                  }
                  echo "</tr>";
                  $first_row = false;
               }
               echo "<tr>";
               foreach ($row as $value) {
                  echo "<td>" . htmlspecialchars($value) . "</td>";
               }
               echo "</tr>";
            }
            echo "</table>";
         }

         mysqli_close($database);
      ?>
   </body>
</html>
