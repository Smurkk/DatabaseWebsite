--QUERY 1--
SELECT H.address FROM House H JOIN Listings L ON H.address = L.address;

--QUERY 2--
SELECT P.address, L.mlsNumber
FROM Property P
JOIN House H ON P.address = H.address
JOIN Listings L ON P.address = L.address;

--QUERY 3--
SELECT H.address
FROM Listings L
JOIN House H ON L.address = H.address
WHERE H.bedrooms = 3 AND H.bathrooms = 2;

--Query 4--
SELECT P.address, P.price
FROM Property P
JOIN House H ON P.address = H.address
WHERE H.bedrooms = 3 
  AND H.bathrooms = 2
  AND P.price BETWEEN 100000 AND 250000
ORDER BY P.price DESC;


--Query 5--
SELECT P.address, P.price
FROM Property P
JOIN BusinessProperty B ON P.address = B.address
WHERE B.type = 'office space'
ORDER BY P.price DESC;

--Query 6--
SELECT A.agentId, A.name AS agent_name, A.phone, F.name AS firm_name, A.dateStarted
FROM Agent A
JOIN Firm F ON A.firmId = F.id;

--Query 7--
SELECT P.address, P.ownerName, P.price
FROM Property P
JOIN Listings L ON P.address = L.address
WHERE L.agentId = 001;

--Query 8--
SELECT A.name AS agent_name, B.name AS buyer_name
FROM Works_With WW
JOIN Agent A ON WW.agentID = A.agentId
JOIN Buyer B ON WW.buyerId = B.id
ORDER BY A.name ASC;

--Query 9--
SELECT A.agentId, COUNT(WW.buyerId) AS buyer_count
FROM Agent A
LEFT JOIN Works_With WW ON A.agentId = WW.agentID
GROUP BY A.agentId;

--Query 10--
SELECT P.address, P.price
FROM Property P
JOIN House H ON P.address = H.address
JOIN Listings L ON P.address = L.address
JOIN Buyer B ON B.id = 001
WHERE B.propertyType = 'house'
  AND H.bedrooms = B.bedrooms
  AND H.bathrooms = B.bathrooms
  AND P.price BETWEEN B.minimumPreferredPrice AND B.maximumPreferredPrice
ORDER BY P.price DESC;


