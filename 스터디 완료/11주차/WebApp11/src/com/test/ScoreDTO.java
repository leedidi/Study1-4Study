package com.test;

public class ScoreDTO
{
	private String name, sid;
	private int scoreKor, scoreEng, scoreMat;
	private int scoreTot;
	private double scoreAvg;
	
	public double getScoreAvg()
	{
		return scoreAvg;
	}
	public void setScoreAvg(double scoreAvg)
	{
		this.scoreAvg = scoreAvg;
	}
	public String getSid()
	{
		return sid;
	}
	public void setSid(String sid)
	{
		this.sid = sid;
	}
	public String getName()
	{
		return name;
	}
	public void setName(String name)
	{
		this.name = name;
	}
	public int getScoreKor()
	{
		return scoreKor;
	}
	public void setScoreKor(int scoreKor)
	{
		this.scoreKor = scoreKor;
	}
	public int getScoreEng()
	{
		return scoreEng;
	}
	public void setScoreEng(int scoreEng)
	{
		this.scoreEng = scoreEng;
	}
	public int getScoreMat()
	{
		return scoreMat;
	}
	public void setScoreMat(int scoreMat)
	{
		this.scoreMat = scoreMat;
	}
	public int getScoreTot()
	{
		return scoreTot;
	}
	public void setScoreTot(int scoreTot)
	{
		this.scoreTot = scoreTot;
	}

	
}
