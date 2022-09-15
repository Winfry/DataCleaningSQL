Select *
From dbo.DataCleaning

------------Standardize Date Format ----------


Select SaleDate, CONVERT(Date, SaleDate) 
From dbo.DataCleaning 

Update DataCleaning
SET SaleDate = CONVERT(Date, SaleDate)

ALTER TABLE DataCleaning
Add SaleDateConvert Date;

Update DataCleaning
SET SaleDate = CONVERT(Date, SaleDate)


--------Populate Property Address Data------
Select PropertyAddress 
From dbo.DataCleaning


Select *  
From dbo.DataCleaning
Where PropertyAddress is null

Select *  
From dbo.DataCleaning
---Where PropertyAddress is null
Order by ParcelID


Select *
From dbo.DataCleaning a
JOIN dbo.DataCleaning b
      on a.ParcelID = b.ParcelID
	  AND a.[UniqueID ] <> b.[UniqueID ]


Select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress
From dbo.DataCleaning a
JOIN dbo.DataCleaning b
      on a.ParcelID = b.ParcelID
	  AND a.[UniqueID ] <> b.[UniqueID ]


Select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress
From dbo.DataCleaning a
JOIN dbo.DataCleaning b
      on a.ParcelID = b.ParcelID
	  AND a.[UniqueID ] <> b.[UniqueID ]
Where a.PropertyAddress is null



Select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress, b.PropertyAddress)
From dbo.DataCleaning a
JOIN dbo.DataCleaning b
      on a.ParcelID = b.ParcelID
	  AND a.[UniqueID ] <> b.[UniqueID ]
Where a.PropertyAddress is null

Update a
SET PropertyAddress = ISNULL(a.PropertyAddress, b.PropertyAddress)
From dbo.DataCleaning a
JOIN dbo.DataCleaning b
   on a.ParcelID = b.ParcelID
   AND a.[UniqueID ] <> b.[UniqueID ]
where a.PropertyAddress is null

------Breaking Out To Indicate Columns(Address, City, State)
Select PropertyAddress
From dbo.DataCleaning
--Where PropertAddress is null
--Order by ParcelID

SELECT 
SUBSTRING(PropertyAddress, 1,  CHARINDEX (',', PropertyAddress) - 1 ) as Address
, SUBSTRING (PropertyAddress, 1, CHARINDEX (',', PropertyAddress) + 1 ), LEN(PropertyAddress) as Address

From dbo.DataCleaning


**To Updating This;

SELECT 
SUBSTRING(PropertyAddress, 1,  CHARINDEX (',', PropertyAddress) - 1 ) as Address
, SUBSTRING (PropertyAddress, 1, CHARINDEX (',', PropertyAddress) + 1 ), LEN(PropertyAddress) as Address

From dbo.DataCleaning

ALTER TABLE dbo.DataCleaning
Add PropertySplitAdd Nvarchar(255);

Update dbo.DataCleaning
SET PropertySplitAddress = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) +1), LEN(PropertyAddress)

Select OwnerAddress
From dbo.DataCleaning

----------Change Y and N to Yes No in "Sold  As Vacant" field
Select Distinct(SoldAsVacant), Count(SoldAsVacant)
From dbo.DataCleaning
Group by SoldAsVacant
Order by 2

Select SoldAsVacant
,CASE When SoldAsVacant = 'Y' THEN 'Yes'
      When SoldAsVacant = 'N' THEN 'No'
	  ELSE SoldAsVacant 
	  END
From dbo.DataCleaning

**Updating
Select SoldAsVacant
,CASE When SoldAsVacant = 'Y' THEN 'Yes'
      When SoldAsVacant = 'N' THEN 'No'
	  ELSE SoldAsVacant 
	  END
From dbo.DataCleaning

Update dbo.DataCleaning
SET SoldAsVacant =CASE When SoldAsVacant
                 ='Y' THEN 'Yes'
    When SoldAsVacant = 'N' THEN 'No'
	Else SoldAsVacant
	END



------Removing Duplicates
Select *
ROW_NUMBER() Over (
PARTITION BY Parcel ID,
             PropertyAddress,
			 SalePrice,
			 SaleDate,
			 Legal Reference
			 ORDER BY
			     UniqueID
                 )row_num
From dbo.DataCleaning


Select *
ROW_NUMBER ()Over (
PARTITION BY Parcel ID,
             PropertyAddress,
			 SalePrice,
			 SaleDate,
			 Legal Reference
			 ORDER BY
			     UniqueID
                 )row_num
From dbo.DataCleaning
Order by ParcelID

WITH RowNumCTE AS(
Select *,
      ROW_NUMBER()OVER(
	  PARTITION BY ParcelID,
	               PropertyAddress,
				   SalePrice,
				   SaleDate,
				   LegalReference
				   ORDER BY 
				      UniqueID
					  )row_num
From dbo.DataCleaning
)
Select*
From RowNumCTE

WITH RowNumCTE AS(
Select *,
      ROW_NUMBER()OVER(
	  PARTITION BY ParcelID,
	               PropertyAddress,
				   SalePrice,
				   SaleDate,
				   LegalReference
				   ORDER BY 
				      UniqueID
					  )row_num
From dbo.DataCleaning
)
Select*
From RowNumCTE
Where row_num >1
Order by PropertyAddress



WITH RowNumCTE AS(
DELETE,
      ROW_NUMBER()OVER(
	  PARTITION BY ParcelID,
	               PropertyAddress,
				   SalePrice,
				   SaleDate,
				   LegalReference
				   ORDER BY 
				      UniqueID
					  )row_num
From dbo.DataCleaning
)
Select*
From RowNumCTE
Where row_num >1 
Order by PropertyAddress




				   

				   



