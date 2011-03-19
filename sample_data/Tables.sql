USE [IMI_Bucket]
GO

/****** Object:  Table [dbo].[tbl_NPS_Comments]    Script Date: 03/13/2011 20:07:12 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[tbl_NPS_Comments](
	[Week_ID] [float] NULL,
	[CONTACTNAME] [varchar](64) NULL,
	[Score] [nvarchar](5) NULL,
	[Comment] [ntext] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO


USE [IMI_Bucket]
GO

/****** Object:  Table [dbo].[tbl_NPS_Score]    Script Date: 03/13/2011 20:07:38 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tbl_NPS_Score](
	[Week_ID] [float] NULL,
	[NPS] [float] NULL,
	[Score] [int] NULL,
	[Count] [int] NULL
) ON [PRIMARY]

GO

