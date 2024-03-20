Select *
From [Portfolio project]..NashVilleHousing

--Standardize Date format

--Aun no se si esto está bien del todo
Select SaleDateConverted, CONVERT(Date,SaleDate) 
From [Portfolio project]..NashVilleHousing


Update [Portfolio project]..NashVilleHousing
SET SaleDate = CONVERT (Date,SaleDate)

Alter table [Portfolio project]..NashVilleHousing
add SaleDateConverted Date;

Update [Portfolio project]..NashVilleHousing
SET SaleDateConverted = CONVERT (Date,SaleDate)

-- Populate Property Address data

Select *
From [Portfolio project]..NashVilleHousing
--where PropertyAddress is null
order by ParcelID

Select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress,  b.PropertyAddress)
From [Portfolio project]..NashVilleHousing a
Join [Portfolio project]..NashVilleHousing b
 on a.ParcelID = b.ParcelID
 and a.[UniqueID ] <> b.[UniqueID ]
where a.PropertyAddress is null 

update a
SET PropertyAddress = ISNULL(a.PropertyAddress, b.PropertyAddress)
From [Portfolio project]..NashVilleHousing a
Join [Portfolio project]..NashVilleHousing b
 on a.ParcelID = b.ParcelID
 and a.[UniqueID ] <> b.[UniqueID ]
where a.PropertyAddress is null 


-- Breaking out address into individual columns (address, city, State)

Select PropertyAddress
From [Portfolio project]..NashVilleHousing
--where PropertyAddress is null
--order by ParcelID

Select
SUBSTRING (PropertyAddress, 1, CHARINDEX(',', PropertyAddress ) -1 ) as Address
, SUBSTRING (PropertyAddress, CHARINDEX(',', PropertyAddress ) +1, Len(PropertyAddress)) as Address
--charindex is a number about position, -1 dissapears the coma ','
--LEN is the length and means the position in this case, (in substitution from the 1 from above)
From [Portfolio project]..NashVilleHousing

Alter table [Portfolio project]..NashVilleHousing
add PropertySplitAddress Nvarchar(255);

Update [Portfolio project]..NashVilleHousing
SET PropertySplitAddress = SUBSTRING (PropertyAddress, 1, CHARINDEX(',', PropertyAddress ) -1 ) 


Alter table [Portfolio project]..NashVilleHousing
add PropertySplitCity Nvarchar(255);

Update [Portfolio project]..NashVilleHousing
SET PropertySplitCity = SUBSTRING (PropertyAddress, CHARINDEX(',', PropertyAddress ) +1, Len(PropertyAddress))


Select *
From [Portfolio project]..NashVilleHousing

--Esta forma de hacerlo es mucho mejor
Select
PARSENAME(REPLACE(Owneraddress, ',','.') ,3) as Address
,PARSENAME(REPLACE(Owneraddress, ',','.') ,2) as City
,PARSENAME(REPLACE(Owneraddress, ',','.') ,1) as State
From [Portfolio project]..NashVilleHousing
Order by 1




Alter table [Portfolio project]..NashVilleHousing
add OwnerSplitAddress Nvarchar(255);

Update [Portfolio project]..NashVilleHousing
SET OwnerSplitAddress = PARSENAME(REPLACE(Owneraddress, ',','.') ,3) 



Alter table [Portfolio project]..NashVilleHousing
add OwnerSplitCity Nvarchar(255);

Update [Portfolio project]..NashVilleHousing
SET OwnerSplitCity = PARSENAME(REPLACE(Owneraddress, ',','.') ,2) 


Alter table [Portfolio project]..NashVilleHousing
add OwnerSplitState Nvarchar(255);

Update [Portfolio project]..NashVilleHousing
SET OwnerSplitState = PARSENAME(REPLACE(Owneraddress, ',','.') ,1) 

Select *
From [Portfolio project]..NashVilleHousing

-- Change Y and N to Yes and No in "Sold  as vacant" field

select Distinct(SoldAsVacant), COUNT(SoldAsVacant)
From [Portfolio project]..NashVilleHousing
Group by SoldAsVacant
Order by 2


Select SoldAsVacant
, Case when SoldAsVacant = 'Y' Then 'Yes'
       when SoldAsVacant = 'N' Then 'No'
	   Else SoldAsVacant
	   END
From [Portfolio project]..NashVilleHousing

update [Portfolio project]..NashVilleHousing
SET SoldAsVacant = Case when SoldAsVacant = 'Y' Then 'Yes'
       when SoldAsVacant = 'N' Then 'No'
	   Else SoldAsVacant
	   END


-- Remove Duplicates

WITH RowNumCTE AS (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY ParcelID, SaleDate, LegalReference
               ORDER BY UniqueID
           ) AS row_num
    FROM [Portfolio project]..NashVilleHousing
)
select *
FROM RowNumCTE
WHERE row_num > 1
ORDER BY PropertyAddress;



--Delete Unused columns

Select *
From [Portfolio project]..NashVilleHousing

Alter Table [Portfolio project]..NashVilleHousing
Drop column PropertyAddress, SaleDate, SaleDatedConverted, OwnerAddress