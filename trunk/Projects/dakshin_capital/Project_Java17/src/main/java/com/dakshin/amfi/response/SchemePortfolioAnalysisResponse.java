package com.dakshin.amfi.response;

import java.util.HashMap;
import java.util.List;

import com.dakshin.amfi.model.SchemePortfolio;

public class SchemePortfolioAnalysisResponse 
{
	public String instrumentCategoryAllocationMorrisString;
	public String instrumentCategoryAllocationString;
	public HashMap<String, Double> instrumentCategoryAllocationMap;
	
	public List<SchemePortfolio> schemePortfolioList;
	public List<String> schemePortfolioHoldingsNamesString;
	public List<Double> schemePortfolioHoldingsValuesString;
	
	public String sectorAllocationString;
	public List<Double> sectorAllocationMorrisString;
	public List<String> sectorNamesString;
	public HashMap<String, Double> sectorAllocationMap;
	
	public String equityCompaniesAllocationString;
	public String equityCompaniesAllocationMorrisString;
	public HashMap<String, Double> equityCompaniesAllocationMap;
	
	public String debtCompaniesAllocationString;
	public String debtCompaniesAllocationMorrisString;
	public HashMap<String, Double> debtCompaniesAllocationMap;
	
	public HashMap<String, Double> assetAllocationMap;
	
	public String getInstrumentCategoryAllocationMorrisString() {
		return instrumentCategoryAllocationMorrisString;
	}
	public void setInstrumentCategoryAllocationMorrisString(
			String instrumentCategoryAllocationMorrisString) {
		this.instrumentCategoryAllocationMorrisString = instrumentCategoryAllocationMorrisString;
	}
	public String getInstrumentCategoryAllocationString() {
		return instrumentCategoryAllocationString;
	}
	public void setInstrumentCategoryAllocationString(
			String instrumentCategoryAllocationString) {
		this.instrumentCategoryAllocationString = instrumentCategoryAllocationString;
	}
	public HashMap<String, Double> getInstrumentCategoryAllocationMap() {
		return instrumentCategoryAllocationMap;
	}
	public void setInstrumentCategoryAllocationMap(
			HashMap<String, Double> instrumentCategoryAllocationMap) {
		this.instrumentCategoryAllocationMap = instrumentCategoryAllocationMap;
	}
	public String getSectorAllocationString() {
		return sectorAllocationString;
	}
	public void setSectorAllocationString(String sectorAllocationString) {
		this.sectorAllocationString = sectorAllocationString;
	}
	public HashMap<String, Double> getSectorAllocationMap() {
		return sectorAllocationMap;
	}
	public void setSectorAllocationMap(HashMap<String, Double> sectorAllocationMap) {
		this.sectorAllocationMap = sectorAllocationMap;
	}
	public String getEquityCompaniesAllocationString() {
		return equityCompaniesAllocationString;
	}
	public void setEquityCompaniesAllocationString(
			String equityCompaniesAllocationString) {
		this.equityCompaniesAllocationString = equityCompaniesAllocationString;
	}
	public String getEquityCompaniesAllocationMorrisString() {
		return equityCompaniesAllocationMorrisString;
	}
	public void setEquityCompaniesAllocationMorrisString(
			String equityCompaniesAllocationMorrisString) {
		this.equityCompaniesAllocationMorrisString = equityCompaniesAllocationMorrisString;
	}
	public HashMap<String, Double> getEquityCompaniesAllocationMap() {
		return equityCompaniesAllocationMap;
	}
	public void setEquityCompaniesAllocationMap(
			HashMap<String, Double> equityCompaniesAllocationMap) {
		this.equityCompaniesAllocationMap = equityCompaniesAllocationMap;
	}
	public String getDebtCompaniesAllocationString() {
		return debtCompaniesAllocationString;
	}
	public void setDebtCompaniesAllocationString(
			String debtCompaniesAllocationString) {
		this.debtCompaniesAllocationString = debtCompaniesAllocationString;
	}
	public String getDebtCompaniesAllocationMorrisString() {
		return debtCompaniesAllocationMorrisString;
	}
	public void setDebtCompaniesAllocationMorrisString(
			String debtCompaniesAllocationMorrisString) {
		this.debtCompaniesAllocationMorrisString = debtCompaniesAllocationMorrisString;
	}
	public HashMap<String, Double> getDebtCompaniesAllocationMap() {
		return debtCompaniesAllocationMap;
	}
	public void setDebtCompaniesAllocationMap(
			HashMap<String, Double> debtCompaniesAllocationMap) {
		this.debtCompaniesAllocationMap = debtCompaniesAllocationMap;
	}
	public List<SchemePortfolio> getSchemePortfolioList() {
		return schemePortfolioList;
	}
	public void setSchemePortfolioList(List<SchemePortfolio> schemePortfolioList) {
		this.schemePortfolioList = schemePortfolioList;
	}
	public List<String> getSchemePortfolioHoldingsNamesString() {
		return schemePortfolioHoldingsNamesString;
	}
	public void setSchemePortfolioHoldingsNamesString(
			List<String> schemePortfolioHoldingsNamesString) {
		this.schemePortfolioHoldingsNamesString = schemePortfolioHoldingsNamesString;
	}
	public List<Double> getSchemePortfolioHoldingsValuesString() {
		return schemePortfolioHoldingsValuesString;
	}
	public void setSchemePortfolioHoldingsValuesString(
			List<Double> schemePortfolioHoldingsValuesString) {
		this.schemePortfolioHoldingsValuesString = schemePortfolioHoldingsValuesString;
	}
	public List<Double> getSectorAllocationMorrisString() {
		return sectorAllocationMorrisString;
	}
	public void setSectorAllocationMorrisString(
			List<Double> sectorAllocationMorrisString) {
		this.sectorAllocationMorrisString = sectorAllocationMorrisString;
	}
	public List<String> getSectorNamesString() {
		return sectorNamesString;
	}
	public void setSectorNamesString(List<String> sectorNamesString) {
		this.sectorNamesString = sectorNamesString;
	}
	public HashMap<String, Double> getAssetAllocationMap() {
		return assetAllocationMap;
	}
	public void setAssetAllocationMap(HashMap<String, Double> assetAllocationMap) {
		this.assetAllocationMap = assetAllocationMap;
	}
	
	
}
