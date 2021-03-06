USE [tycho_kc]
GO
/****** Object:  Table [dbo].[UserOption]    Script Date: 06/16/2015 14:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[UserOption](
	[username] [varchar](50) NOT NULL,
	[option1] [varchar](20) NOT NULL,
 CONSTRAINT [PK_UserOption] PRIMARY KEY CLUSTERED 
(
	[username] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[UploadToInfoSystem]    Script Date: 06/16/2015 14:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[UploadToInfoSystem](
	[uploadTime] [datetime] NOT NULL,
	[testDateTime] [datetime] NOT NULL,
	[dataType] [tinyint] NOT NULL,
	[needUpload] [tinyint] NOT NULL,
	[retMsg] [varchar](50) NULL,
 CONSTRAINT [PK_UploadToInfoSystem] PRIMARY KEY CLUSTERED 
(
	[uploadTime] ASC,
	[testDateTime] ASC,
	[dataType] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  UserDefinedFunction [dbo].[TransformEngNum]    Script Date: 06/16/2015 14:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**********************************************************************************************
-- 创建：董辉
-- 时间：2014-9-17 9:06
-- 说明：转换编组号为指定格式
**********************************************************************************************/
create function [dbo].[TransformEngNum]
(
	@in_EngNum nvarchar(50) --编组号
)

returns nvarchar(50)

as

begin

	--返回结果变量
	declare @Out_Result nvarchar(50);
	
	if @in_EngNum = ''
		begin
		
			set @Out_Result = '未知';
		
		end
	else
		begin
		
			if CHARINDEX('-',@in_EngNum) > 1
				BEGIN
				
					set @Out_Result = SUBSTRING(@in_EngNum,0,CHARINDEX('-',@in_EngNum));
				
				END
			ELSE
				BEGIN
				
					set @Out_Result = '未知';
				
				END
		end
		
	return @Out_Result;

end
GO
/****** Object:  Table [dbo].[TrainType]    Script Date: 06/16/2015 14:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TrainType](
	[trainType] [varchar](20) NOT NULL,
	[trainNoFrom] [int] NOT NULL,
	[trainNoTo] [int] NOT NULL,
	[format] [varchar](20) NOT NULL,
 CONSTRAINT [PK_TrainType] PRIMARY KEY CLUSTERED 
(
	[trainNoFrom] ASC,
	[trainNoTo] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TrainInfo]    Script Date: 06/16/2015 14:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TrainInfo](
	[TrainID] [varchar](30) NOT NULL,
	[DefaultWheelDia] [numeric](5, 1) NULL,
	[Describe] [varchar](50) NULL,
	[No] [tinyint] NULL,
 CONSTRAINT [PK_TrainInfo] PRIMARY KEY CLUSTERED 
(
	[TrainID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[thresholds_dev]    Script Date: 06/16/2015 14:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[thresholds_dev](
	[name] [varchar](10) NOT NULL,
	[standard] [numeric](8, 2) NULL,
	[up_level2] [numeric](8, 2) NULL,
	[up_level1] [numeric](8, 2) NULL,
	[low_level2] [numeric](8, 2) NULL,
	[low_level1] [numeric](8, 2) NULL,
	[desc] [varchar](50) NULL,
 CONSTRAINT [PK_thresholds_dev] PRIMARY KEY CLUSTERED 
(
	[name] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[thresholds]    Script Date: 06/16/2015 14:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[thresholds](
	[trainType] [varchar](20) NOT NULL,
	[name] [varchar](10) NOT NULL,
	[standard] [numeric](8, 2) NULL,
	[up_level3] [numeric](8, 2) NULL,
	[up_level2] [numeric](8, 2) NULL,
	[up_level1] [numeric](8, 2) NULL,
	[low_level3] [numeric](8, 2) NULL,
	[low_level2] [numeric](8, 2) NULL,
	[low_level1] [numeric](8, 2) NULL,
	[desc] [varchar](100) NULL,
	[precision] [numeric](5, 2) NULL,
 CONSTRAINT [PK_thresholds_1] PRIMARY KEY CLUSTERED 
(
	[trainType] ASC,
	[name] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SysStatus]    Script Date: 06/16/2015 14:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SysStatus](
	[testDateTime] [datetime] NULL,
	[zhDatas] [varchar](200) NULL,
	[Device] [varchar](50) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SW_noWork]    Script Date: 06/16/2015 14:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SW_noWork](
	[testTime] [datetime] NOT NULL,
	[cyNo] [tinyint] NOT NULL,
	[swNo] [tinyint] NOT NULL,
 CONSTRAINT [PK_SW_noWork] PRIMARY KEY CLUSTERED 
(
	[testTime] ASC,
	[cyNo] ASC,
	[swNo] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SW_flash]    Script Date: 06/16/2015 14:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SW_flash](
	[testTime] [datetime] NOT NULL,
	[cyNo] [tinyint] NOT NULL,
	[swNo] [tinyint] NOT NULL,
 CONSTRAINT [PK_SW_flash] PRIMARY KEY CLUSTERED 
(
	[testTime] ASC,
	[cyNo] ASC,
	[swNo] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Sequ_temp]    Script Date: 06/16/2015 14:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sequ_temp](
	[ip] [int] NOT NULL,
	[axle] [int] NOT NULL,
	[stamp] [int] NULL,
	[unit] [int] NULL,
 CONSTRAINT [PK_test] PRIMARY KEY CLUSTERED 
(
	[ip] ASC,
	[axle] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProfileChangeLjLog]    Script Date: 06/16/2015 14:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProfileChangeLjLog](
	[testDateTime] [datetime] NOT NULL,
	[AxleNo] [int] NOT NULL,
	[WheelNo] [int] NOT NULL,
	[ChangeValue] [nvarchar](50) NULL,
	[ChangeSource] [int] NULL,
	[ChangeColumn] [nvarchar](50) NULL
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'1代表从上一次数据更改，2代表从对立轮子的数据更改' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ProfileChangeLjLog', @level2type=N'COLUMN',@level2name=N'ChangeSource'
GO
/****** Object:  Table [dbo].[ProfileAdjust]    Script Date: 06/16/2015 14:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProfileAdjust](
	[position] [tinyint] NOT NULL,
	[Lj] [numeric](3, 1) NOT NULL,
	[LyHd] [numeric](3, 1) NOT NULL,
	[LyGd] [numeric](3, 1) NOT NULL,
	[LwHd] [numeric](3, 1) NOT NULL,
	[LwHd2] [numeric](3, 1) NOT NULL,
	[QR] [numeric](3, 1) NOT NULL,
	[Ncj] [numeric](3, 1) NOT NULL,
 CONSTRAINT [PK_ProfileAdjust] PRIMARY KEY CLUSTERED 
(
	[position] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'0左1右' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ProfileAdjust', @level2type=N'COLUMN',@level2name=N'position'
GO
/****** Object:  Table [dbo].[Verify]    Script Date: 06/16/2015 14:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Verify](
	[VerifyDate] [date] NOT NULL,
	[name] [varchar](20) NOT NULL,
	[desc] [varchar](max) NULL,
	[CommitTime] [datetime] NULL,
 CONSTRAINT [PK_Verify] PRIMARY KEY CLUSTERED 
(
	[VerifyDate] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  UserDefinedFunction [dbo].[wheelPos2]    Script Date: 06/16/2015 14:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[wheelPos2]
(@carNo varchar(20) ,@axleNo int,@wheelNo int,@direction int)
RETURNS int
AS

--BEGIN
--declare @ret int
--declare @axleNum int
--
--if (@direction = 1)
--	begin
--		set @ret = @axlePos*2 + 1
--		if (@wheelNo = 0)
--			set @ret = @ret +1
--	end
--else
--	begin
--		select @axleNum=axleNum from car where carNo=@carNo
--		set @ret = (@axleNum-@axlePos-1)*2 + 1
--		if (@wheelNo = 1)
--			set @ret = @ret +1
--	end
--RETURN @ret
--END

BEGIN
declare @ret int
set @axleNo = @axleNo % 4
if (@direction = 1)
	begin
		set @ret = @axleNo*2 + 1
		if (@wheelNo = 0)
			set @ret = @ret +1
	end
else
	begin
		set @ret = (3-@axleNo)*2 + 1
		if (@wheelNo = 1)
			set @ret = @ret +1
	end
RETURN @ret
END
GO
/****** Object:  Table [dbo].[ProfilePatchLog2]    Script Date: 06/16/2015 14:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ProfilePatchLog2](
	[testdatetime] [datetime] NOT NULL,
	[axleNo] [tinyint] NOT NULL,
	[wheelNo] [tinyint] NOT NULL,
	[carNo] [varchar](20) NULL,
	[pos] [tinyint] NULL,
	[lj_org] [numeric](5, 1) NULL,
	[lj_use] [numeric](5, 1) NULL,
 CONSTRAINT [PK_ProfilePatchLog2] PRIMARY KEY CLUSTERED 
(
	[testdatetime] ASC,
	[axleNo] ASC,
	[wheelNo] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ProfilePatchLog0]    Script Date: 06/16/2015 14:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ProfilePatchLog0](
	[testdatetime] [datetime] NOT NULL,
	[axleNo] [tinyint] NOT NULL,
	[wheelNo] [tinyint] NOT NULL,
	[carNo] [varchar](20) NULL,
	[pos] [tinyint] NULL,
	[lj_org] [numeric](5, 1) NULL,
	[lj_use] [numeric](5, 1) NULL,
 CONSTRAINT [PK_ProfilePatchLog0] PRIMARY KEY CLUSTERED 
(
	[testdatetime] ASC,
	[axleNo] ASC,
	[wheelNo] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ProfilePatchLog]    Script Date: 06/16/2015 14:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ProfilePatchLog](
	[testdatetime] [datetime] NOT NULL,
	[axleNo] [tinyint] NOT NULL,
	[wheelNo] [tinyint] NOT NULL,
	[carNo] [varchar](20) NULL,
	[pos] [tinyint] NULL,
	[lj_org] [numeric](5, 1) NULL,
	[lj_use] [numeric](5, 1) NULL,
 CONSTRAINT [PK_ProfilePatchLog] PRIMARY KEY CLUSTERED 
(
	[testdatetime] ASC,
	[axleNo] ASC,
	[wheelNo] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[operate]    Script Date: 06/16/2015 14:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[operate](
	[id] [tinyint] NOT NULL,
	[name] [varchar](20) NOT NULL,
 CONSTRAINT [PK_operate] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[log]    Script Date: 06/16/2015 14:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[log](
	[dt] [datetime] NOT NULL,
	[name] [varchar](50) NOT NULL,
	[ip] [varchar](20) NULL,
	[op] [tinyint] NULL,
	[data] [varchar](50) NULL,
 CONSTRAINT [PK_log] PRIMARY KEY CLUSTERED 
(
	[dt] ASC,
	[name] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  StoredProcedure [dbo].[proc_LJ_BatchDatafill]    Script Date: 06/16/2015 14:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**********************************************************************************************
-- 创建：董辉
-- 时间：2014-12-30 14:01
-- 说明：外形轮径数据调整（当前轮径非正常数据时，查找对应的上一次数据填补此次数据，若上次数据
		 也为非正常数据，则以当前轮子的左或右轮数据填补，若当前轮子的左或右轮也为非正常数据则
		 不处理）
**********************************************************************************************/

CREATE proc [dbo].[proc_LJ_BatchDatafill]
(
	@in_testDateTime   datetime,        --检测日期
	
	@in_CheckColumn    nvarchar(50),    --被检测字段
	
	@in_BaseValue	   decimal(5,1),    --被检测字段的基准值
	
	@out_Result		   int output	    --处理结果（0出错，1轮径数据正常不需处理，2正确处理完成）
)

as

begin 

	--不返回受影响行数信息
	set NOCOUNT ON;
	
	--开启事务
	begin TRAN;
	
	--异常捕获
	begin TRY
	
		--定义检测列各变量
		declare @ColumnName		nvarchar(100) = '',--列名
				@ColumnType		nvarchar(50) = '', --列类型
				@ColumnLength	int = 0,		   --列长度（若为浮点数时）
				@ColumnDenum	int = 0;		   --列小数点后保留位数（若为浮点数时）
				
		--检测字段在指定的表中是否存在
		select 
			@ColumnName = b.name,
			@ColumnType = c.name,
			@ColumnLength = b.length,
			@ColumnDenum = (case c.name when 'datetime' then 0 else b.xscale end)
		from sysobjects a join syscolumns b
		on a.id = b.id
			join systypes c
		on b.xtype = c.xtype
		where 
			a.type = 'U'
			and a.name = 'ProfileDetectResult'
			and b.name = @in_CheckColumn;
			
		--如果列名或列类型为空说明在指定的表中
		--没有指定的列，则不作任何处理
		if @ColumnName = '' or @ColumnType = ''
			BEGIN

				set @out_Result = 0;
				
				rollback tran;
				
				return;
			
			END

		--定义是否需要检测的定量
		declare @CheckedRowCount int;
		
		--定义脚本执行变量
		declare @CheckedSQL nvarchar(500);
		
		--拼合脚本
		set @CheckedSQL = N'select @CheckedRowCount = count(1) from ProfileDetectResult where testDateTime = '''+ convert(nvarchar,@in_testDateTime,120) +''' ';
		
		--拼合脚本
		set @CheckedSQL += N'and ' + @in_CheckColumn + ' = ' + convert(nvarchar,@in_BaseValue) + '';

		--执行脚本并传出检测结果
		EXEC sp_executesql @CheckedSQL,N'@CheckedRowCount int OUTPUT',@CheckedRowCount OUTPUT;
		
		--检测本次日期是否需要处理，大于0需要处理，等于0不需要
		if @CheckedRowCount > 0
			BEGIN
			
			--定义动态执行的脚本变量
			declare @RunSQL nvarchar(4000);
			
			set @RunSQL  = N'declare  @i	 int = 1,';--循环因子
			set @RunSQL += N'@Count   int,			';--总行数
		    set @RunSQL += N'@CarNo   varchar(20),   ';--车号
		    set @RunSQL += N'@pos     tinyint,		';--轮位号
		    set @RunSQL += N'@axleNo  int,		    ';--轴号
		    set @RunSQL += N'@wheelNo int;		    ';--轮号（左轮或右轮）
				    
			--定义数据表对象
			set @RunSQL += N'declare @AbnormalData table([ID] int not null IDENTITY(1,1),[axleNo] int not null,[wheelNo] int not null);';
			
			if @ColumnType = 'nvarchar' or @ColumnType = 'varchar' or @ColumnType = 'decimal' or @ColumnType = 'numeric'
				BEGIN
				
					--定义前次日期数据表对象
					set @RunSQL += N'declare @LastTimeData table([testDateTime] datetime not null,[axleNo] int not null,[wheelNo] int not null,['+@ColumnName+'] '+@ColumnType+'('+cast(@ColumnLength as nvarchar)+','+cast(@ColumnDenum as nvarchar)+'));';
				
				END
			ELSE
				BEGIN
				
					--定义前次日期数据表对象
					set @RunSQL += N'declare @LastTimeData table([testDateTime] datetime not null,[axleNo] int not null,[wheelNo] int not null,['+@ColumnName+'] '+@ColumnType+');';
				
				END
				
			--非正常数据存入数据表对象
			set @RunSQL += N'insert into @AbnormalData select axleNo,wheelNo from ProfileDetectResult where testDateTime = '''+convert(nvarchar,@in_testDateTime,120)+''' and '+@ColumnName+' = '+cast(@in_BaseValue as nvarchar)+';';
			
			--计算总行数
			set @RunSQL += N'select @Count = count(1) from @AbnormalData;';

			set @RunSQL += N'WHILE @i <= @Count ';
			set @RunSQL += N'BEGIN ';
				
					--数据轴号与轮号
					set @RunSQL += N'select @axleNo = axleNo,@wheelNo = wheelNo from @AbnormalData where [ID] = @i; ';
					
					--查找当前轮子对应的车号与轮位号
					set @RunSQL += N'select ';
					set @RunSQL += N'@CarNo = b.carNo,';
					set @RunSQL += N'@pos = b.pos ';
					set @RunSQL += N'from ProfileDetectResult a join ProfileDetectResult_real b '; 
					set @RunSQL += N'on a.testDateTime = b.testDateTime ';
					set @RunSQL += N'and a.axleNo = b.axleNo ';
					set @RunSQL += N'and a.wheelNo = b.wheelNo ';
					set @RunSQL += N'where a.testDateTime = '''+convert(nvarchar,@in_testDateTime,120)+''' ';
					set @RunSQL += N'and b.axleNo = @axleNo ';
					set @RunSQL += N'and b.wheelNo = @wheelNo;';
						  
					--查找当前轮子的上一次数据
					set @RunSQL += N'insert into @LastTimeData ';
					set @RunSQL += N'select top 1 ';
					set @RunSQL += N'testDateTime,';
				    set @RunSQL += N'axleNo,';
				    set @RunSQL += N'wheelNo,';
				    set @RunSQL += N''+@ColumnName+' ';
					set @RunSQL += N'from ProfileDetectResult_real '; 
					set @RunSQL += N'where '; 
					set @RunSQL += N'carNo = @CarNo ';
					set @RunSQL += N'and pos = @pos ';
					set @RunSQL += N'and testDateTime <> '''+convert(nvarchar,@in_testDateTime,120)+''' ';
					set @RunSQL += N'and testDateTime < '''+convert(nvarchar,@in_testDateTime,120)+''' ';
					set @RunSQL += N'order by testDateTime desc;';
					
					--如果上一次轮径为正常的数据则以上一次的数据为准更改当前的数据
					set @RunSQL += N'if exists(select testDateTime from @LastTimeData where '+@ColumnName+' <> '+cast(@in_BaseValue as nvarchar(10))+') ';
						set @RunSQL += N'BEGIN ';
						
							--更改当前轮径数据
							set @RunSQL += N'update ProfileDetectResult '; 
							set @RunSQL += N'set '+@ColumnName+' = (select '+@ColumnName+' from @LastTimeData) '; 
							set @RunSQL += N'where testDateTime = '''+convert(nvarchar,@in_testDateTime,120)+''' ';
							set @RunSQL += N'and axleNo = @axleNo ';
							set @RunSQL += N'and wheelNo = @wheelNo;';
							
							--删除日志信息（若已存在）
							set @RunSQL += N'delete ProfileChangeLjLog where testDateTime = '''+convert(nvarchar,@in_testDateTime,120)+''' ';
							set @RunSQL += N'and AxleNo = @axleNo ';
							set @RunSQL += N'and WheelNo = @wheelNo;';
							
							--记录日志信息
							set @RunSQL += N'insert into ProfileChangeLjLog ';
							set @RunSQL += N'values ';
							set @RunSQL += N'(';
							set @RunSQL += N''''+convert(nvarchar,@in_testDateTime,120)+''',';
							set @RunSQL += N'@axleNo,';
							set @RunSQL += N'@wheelNo,';
							set @RunSQL += N'(select '+@ColumnName+' from @LastTimeData),';
							set @RunSQL += N''+cast(1 as nvarchar)+','
							set @RunSQL += N''''+@ColumnName+''''
							set @RunSQL += N');';
						
						set @RunSQL += N'END ';
					--否则以当前轮子对立的轮子数据为准更改当前数据
					set @RunSQL += N'ELSE ';
						set @RunSQL += N'BEGIN ';
						
							--对立面轮位号变量
							set @RunSQL += N'declare @OtherSide int;';
							
							--更改当前轮子的对立轮位变量值
							set @RunSQL += N'if @wheelNo = '+cast(0 as nvarchar)+' ';
								set @RunSQL += N'BEGIN ';
								
									set @RunSQL += N'set @OtherSide = '+cast(1 as nvarchar)+';';
								
								set @RunSQL += N'END ';
							set @RunSQL += N'ELSE ';
								set @RunSQL += N'BEGIN ';
								
									set @RunSQL += N'set @OtherSide = '+cast(0 as nvarchar)+';';
								
								set @RunSQL += N'END ';
								
							--如果对立的轮子为正常数据则以此数据为准更改当前数据
							set @RunSQL += N'if exists(select testDateTime from ProfileDetectResult_real where testDateTime = '''+convert(nvarchar,@in_testDateTime,120)+''' and axleNo = @axleNo and wheelNo = @OtherSide and '+@ColumnName+' <> '+cast(@in_BaseValue as nvarchar(10))+') ';
								set @RunSQL += N'BEGIN ';
								
									--更改当前轮径数据
									set @RunSQL += N'update ProfileDetectResult set '+@ColumnName+' = ';
									set @RunSQL += N'( ';
										set @RunSQL += N'select '+@ColumnName+' from ProfileDetectResult_real ';
										set @RunSQL += N'where testDateTime = '''+convert(nvarchar,@in_testDateTime,120)+''' ';
										set @RunSQL += N'and axleNo = @axleNo ';
										set @RunSQL += N'and wheelNo = @OtherSide ';
									set @RunSQL += N') ';
									set @RunSQL += N'where testDateTime = '''+convert(nvarchar,@in_testDateTime,120)+''' ';
									set @RunSQL += N'and axleNo = @axleNo ';
									set @RunSQL += N'and wheelNo = @wheelNo;';
									
									--删除日志信息（若已存在）
									set @RunSQL += N'delete ProfileChangeLjLog where testDateTime = '''+convert(nvarchar,@in_testDateTime,120)+''' ';
									set @RunSQL += N'and AxleNo = @axleNo ';
									set @RunSQL += N'and WheelNo = @wheelNo;';
									
									--记录日志信息
									set @RunSQL += N'insert into ProfileChangeLjLog ';
									set @RunSQL += N'values ';
									set @RunSQL += N'( ';
										set @RunSQL += N''''+convert(nvarchar,@in_testDateTime,120)+''','
										set @RunSQL += N'@axleNo,';
										set @RunSQL += N'@wheelNo,';
										set @RunSQL += N'(select '+@ColumnName+' from ProfileDetectResult ';
										  set @RunSQL += N'where testDateTime = '''+convert(nvarchar,@in_testDateTime,120)+''' ';
										  set @RunSQL += N'and axleNo = @axleNo ';
										  set @RunSQL += N'and wheelNo = @OtherSide ';
										set @RunSQL += N'),';
										set @RunSQL += N'2,';
										set @RunSQL += N''''+@ColumnName+'''';
									set @RunSQL += N');';
									
								set @RunSQL += N'END ';
						
						set @RunSQL += N'END ';
					
					--清空上一次数据表内的数据
				    set @RunSQL += N'DELETE @LastTimeData;';
						
					--累计循环因子	
					set @RunSQL += N'set @i += 1;';
				
				set @RunSQL += N'END ';
				
				--执行动态脚本
				exec(@RunSQL);
			
			--设置回传参数标志
			set @out_Result = 2;
			
			END
		ELSE
			BEGIN
			
				--设置回传参数标志
				set @out_Result = 1;
							
			END;
	
		--提交事务
		commit tran;
	
	end TRY
	begin CATCH
	
		--回滚事务并抛出异常给调用方程序
		rollback tran;
		
		--设置回传参数标志
		set @out_Result = 0;
		
		DECLARE @ErrorMessage NVARCHAR(4000);

        DECLARE @ErrorSeverity INT;

        DECLARE @ErrorState INT;
		
		--返回错误信息
        SELECT  @ErrorMessage = ERROR_MESSAGE(),
                @ErrorSeverity = ERROR_SEVERITY(),
                @ErrorState = ERROR_STATE();
        RAISERROR (@ErrorMessage,1,@ErrorState) WITH LOG;

        RETURN;
	
	end CATCH

end
GO
/****** Object:  UserDefinedFunction [dbo].[GetUpgradeTime]    Script Date: 06/16/2015 14:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create FUNCTION [dbo].[GetUpgradeTime]
()
RETURNS datetime
AS

BEGIN
return '2515-05-05 18:00:00'--重要数据，此日期前后，报警方式不一样，一次设好后，不要再更改
END
GO
/****** Object:  UserDefinedFunction [dbo].[Least]    Script Date: 06/16/2015 14:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[Least]
(@val1 SQL_VARIANT,@val2 SQL_VARIANT,@val3 SQL_VARIANT,@val4 SQL_VARIANT,@val5 SQL_VARIANT,@val6 SQL_VARIANT,@val7 SQL_VARIANT)
RETURNS SQL_VARIANT
AS

BEGIN
declare @var SQL_VARIANT
if (@val1 = 0)
    set @val1=20
if (@val2 = 0)
    set @val2=20
if (@val3 = 0)
    set @val3=20
if (@val4 = 0)
    set @val4=20
if (@val5 = 0)
    set @val5=20
if (@val6 = 0)
    set @val6=20
if (@val7 = 0)
    set @val7=20

if (@val1 < @val2) 
    set @var = @val1
else
    set @var = @val2
if (@val3 < @var) 
    set @var = @val3
if (@val4 < @var) 
    set @var = @val4
if (@val5 < @var) 
    set @var = @val5
if (@val6 < @var) 
    set @var = @val6
if (@val7 < @var) 
    set @var = @val7

if (@var = 20)
begin
if (@val1=100 or @val2=100 or @val3=100 or @val4=100 or @val5=100 or @val6=100 or @val7=100)
    set @var = 10;
else
	set @var = 0;
end
RETURN @var
END
GO
/****** Object:  Table [dbo].[language]    Script Date: 06/16/2015 14:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[language](
	[id] [varchar](50) NOT NULL,
	[cn] [varchar](50) NOT NULL,
	[en] [varchar](50) NOT NULL,
 CONSTRAINT [PK_language] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[General]    Script Date: 06/16/2015 14:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[General](
	[Name] [varchar](20) NOT NULL,
	[Value] [varchar](50) NOT NULL,
 CONSTRAINT [PK_General] PRIMARY KEY CLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  UserDefinedFunction [dbo].[fun_SplitStrsToTable]    Script Date: 06/16/2015 14:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**********************************************************************************************
-- 创建：董辉
-- 时间：2014-8-1 12:33
-- 说明：分割字符串并组织成table返回
**********************************************************************************************/
create function [dbo].[fun_SplitStrsToTable]
(
	@SourceStr	   nvarchar(max),
	
	@SpliteOpretor nvarchar(10)
)

returns @table table ([GUID] int IDENTITY(1, 1) not null,[Value] nvarchar(max) not null)

as

begin

	declare @index int,
			@value nvarchar(max);
	
	set @index = charindex(@SpliteOpretor,@SourceStr);
	
	while @index > 0
	
		begin
		
			set @value = substring(@SourceStr,1,charindex(@SpliteOpretor,@SourceStr) - 1);
			
			set @SourceStr = substring(@SourceStr,@index + 1,len(@SourceStr));
			
			set @index = charindex(@SpliteOpretor,@SourceStr);
			
			insert into @table VALUES(@value);
			
		end
		
		insert into @table VALUES(@SourceStr);

	return;
end
GO
/****** Object:  UserDefinedFunction [dbo].[fun_SplitStr]    Script Date: 06/16/2015 14:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*************************************************************************************
作者：董辉
时间：2014-8-1 12:46
类型：新建
说明：用于按指定方式，指定分割符来分割指定的字符串
*************************************************************************************/
create function [dbo].[fun_SplitStr]
(
	@in_Str nvarchar(max),		--要分割的字符串
	
	@in_splitFlag nvarchar(10), --分割标志（按什么来分割）
	
	@in_flag int				--标志（1左分割，2右分割）
)

returns nvarchar(max)

as

begin
	
	declare @OverSplitStr nvarchar(max);
			
	set @OverSplitStr = '';
			
	begin

		IF @in_flag = 1			--左分割
			begin
			
				set @OverSplitStr = left(@in_Str,(charindex(@in_splitFlag,@in_Str) - 1));
			
			end
		else if @in_flag = 2	--右分割
			begin
			
				set @OverSplitStr = right(@in_Str,(len(@in_Str) - charindex(@in_splitFlag,@in_Str)));
			
			end
	end
	
	return @OverSplitStr;

end
GO
/****** Object:  Table [dbo].[FullAxle1]    Script Date: 06/16/2015 14:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FullAxle1](
	[axleNo] [smallint] NULL,
	[wheelNo] [smallint] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FullAxle_all]    Script Date: 06/16/2015 14:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FullAxle_all](
	[axleNo] [smallint] NOT NULL,
	[wheelNo] [smallint] NOT NULL,
 CONSTRAINT [PK_FullAxle_all] PRIMARY KEY CLUSTERED 
(
	[axleNo] ASC,
	[wheelNo] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FullAxle]    Script Date: 06/16/2015 14:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FullAxle](
	[axleNo] [smallint] NULL,
	[wheelNo] [smallint] NULL
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'编程需要，无其他用途' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'FullAxle'
GO
/****** Object:  Table [dbo].[FactoryLib]    Script Date: 06/16/2015 14:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[FactoryLib](
	[id] [varchar](5) NOT NULL,
	[name] [varchar](20) NULL,
 CONSTRAINT [PK_FACTORYLIB] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'所有机车生产厂家的列表' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'FactoryLib'
GO
/****** Object:  Table [dbo].[EngineTypeLib]    Script Date: 06/16/2015 14:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[EngineTypeLib](
	[id] [tinyint] NOT NULL,
	[name] [varchar](20) NULL,
 CONSTRAINT [PK_ENGINETYPELIB] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'所有机车种类的列表，如电力机车、内燃机车、动车等等' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EngineTypeLib'
GO
/****** Object:  UserDefinedFunction [dbo].[GetAxlePosByAxleNo]    Script Date: 06/16/2015 14:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[GetAxlePosByAxleNo]
(@testdatetime datetime ,@axleNo int)
RETURNS int
AS

BEGIN
declare @ret int
set @ret = @axleNo % 4
RETURN @ret
END
GO
/****** Object:  UserDefinedFunction [dbo].[GetCarPosByAxleNo]    Script Date: 06/16/2015 14:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[GetCarPosByAxleNo]
(@testdatetime datetime ,@axleNo int)
RETURNS int
AS

BEGIN
declare @ret int
set @ret = @axleNo/4
RETURN @ret
END
GO
/****** Object:  Table [dbo].[CarType2]    Script Date: 06/16/2015 14:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CarType2](
	[id] [tinyint] NOT NULL,
	[name] [varchar](20) NOT NULL,
	[value] [varchar](20) NOT NULL,
 CONSTRAINT [PK_CarType2] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CarType1]    Script Date: 06/16/2015 14:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CarType1](
	[id] [tinyint] NOT NULL,
	[name] [varchar](20) NOT NULL,
	[value] [varchar](50) NOT NULL,
 CONSTRAINT [PK_CarType1] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[DetectStatus]    Script Date: 06/16/2015 14:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DetectStatus](
	[testDateTime] [datetime] NULL,
	[zhDatas] [varchar](200) NULL,
	[Device] [varchar](50) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[DetectorTypeLib]    Script Date: 06/16/2015 14:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DetectorTypeLib](
	[id] [tinyint] NOT NULL,
	[name] [varchar](10) NULL,
	[angle] [float] NULL,
 CONSTRAINT [PK_DETECTORTYPELIB] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'所有探头种类的列表' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DetectorTypeLib'
GO
/****** Object:  Table [dbo].[DetectorStatus]    Script Date: 06/16/2015 14:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DetectorStatus](
	[testDateTime] [datetime] NOT NULL,
	[ut] [varchar](5) NOT NULL,
	[status] [varchar](100) NOT NULL,
 CONSTRAINT [PK_DetectorStatus] PRIMARY KEY CLUSTERED 
(
	[testDateTime] ASC,
	[ut] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  UserDefinedFunction [dbo].[carPos]    Script Date: 06/16/2015 14:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[carPos]
(@carNo int ,@all int , @direction int)
RETURNS int
AS

BEGIN
declare @ret int
if (@direction = 1)
	begin
		set @ret = @carNo +1
	end
else
	begin
		set @ret = @all-@carNo
	end
RETURN @ret
END
GO
/****** Object:  Table [dbo].[BugResult_log]    Script Date: 06/16/2015 14:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[BugResult_log](
	[dt] [datetime] NOT NULL,
	[operator] [varchar](50) NOT NULL,
	[ip] [varchar](15) NOT NULL,
	[testDateTime] [datetime] NOT NULL,
	[axleNo] [tinyint] NOT NULL,
	[wheelNo] [tinyint] NOT NULL,
	[pos_angle] [numeric](5, 2) NOT NULL,
	[pos_deep] [numeric](5, 2) NOT NULL,
	[isBug] [bit] NOT NULL,
	[reason] [varchar](160) NULL,
 CONSTRAINT [PK_BugResult_log] PRIMARY KEY CLUSTERED 
(
	[dt] ASC,
	[operator] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CRH_wheel]    Script Date: 06/16/2015 14:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CRH_wheel](
	[trainType] [varchar](20) NOT NULL,
	[axleNo] [tinyint] NOT NULL,
	[wheelNo] [tinyint] NOT NULL,
	[axlePos] [tinyint] NOT NULL,
	[wheelPos] [tinyint] NOT NULL,
 CONSTRAINT [PK_CRH_wheel] PRIMARY KEY CLUSTERED 
(
	[trainType] ASC,
	[axleNo] ASC,
	[wheelNo] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CRH_Car]    Script Date: 06/16/2015 14:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CRH_Car](
	[trainType] [varchar](20) NOT NULL,
	[carPos] [tinyint] NOT NULL,
	[carNo] [varchar](10) NOT NULL,
	[axleType] [char](10) NOT NULL,
	[dir] [bit] NOT NULL,
 CONSTRAINT [PK_CRH_Car] PRIMARY KEY CLUSTERED 
(
	[trainType] ASC,
	[carPos] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  UserDefinedFunction [dbo].[axlePos]    Script Date: 06/16/2015 14:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[axlePos]
(@czh varchar(50), @axleNo int,@direction int)
RETURNS int
AS

BEGIN
declare @ret int
declare @trainType varchar(20)
declare @bz_dir int
declare @axleNum int

--动车
if (CHARINDEX('-',@czh) > 0)
	set @trainType= left(@czh,CHARINDEX('-',@czh)-1)
else
	set @trainType= 'CRH2' --默认车型
	
select	@axleNum = count(*)/2 from CRH_wheel where trainType=@trainType


if (@direction = 1)
	select @ret = axlePos from CRH_wheel where trainType=@trainType and axleNo=@axleNo % @axleNum 
else
	select @ret = axlePos from CRH_wheel where trainType=@trainType and axleNo=(@axleNum-(@axleNo%@axleNum)-1) 

return @ret

--客车机车
--set @axleNo = @axleNo % 4
--if (@direction = 1)
--	begin
--		set @ret = @axleNo+1
--	end
--else
--	begin
--		set @ret = 3-@axleNo+1
--	end
--RETURN @ret
END
GO
/****** Object:  Table [dbo].[CarriageInfo]    Script Date: 06/16/2015 14:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CarriageInfo](
	[CarriageId] [varchar](12) NOT NULL,
	[TrainID] [varchar](30) NOT NULL,
	[orderNum] [int] NOT NULL,
	[axleNum] [tinyint] NOT NULL,
 CONSTRAINT [PK_CarriageInfo] PRIMARY KEY CLUSTERED 
(
	[CarriageId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'车厢ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CarriageInfo', @level2type=N'COLUMN',@level2name=N'CarriageId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'车厢号(序号)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CarriageInfo', @level2type=N'COLUMN',@level2name=N'orderNum'
GO
/****** Object:  Table [dbo].[EngineLib]    Script Date: 06/16/2015 14:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[EngineLib](
	[id] [varchar](5) NOT NULL,
	[name] [varchar](5) NULL,
	[fullName] [varchar](20) NULL,
	[factoryId] [varchar](5) NULL,
	[typeId] [tinyint] NULL,
	[wheelSize] [numeric](6, 2) NULL,
	[wheelSizeB] [numeric](6, 2) NULL,
	[axleNum] [tinyint] NULL,
 CONSTRAINT [PK_ENGINELIB] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'如DF4、SS4、HX3等等' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EngineLib', @level2type=N'COLUMN',@level2name=N'name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'中文全称，如东风4、韶4、和谐3等等' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EngineLib', @level2type=N'COLUMN',@level2name=N'fullName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'该车型，A轮径出厂标准值，单位为mm' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EngineLib', @level2type=N'COLUMN',@level2name=N'wheelSize'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'该车型，B轮径出厂标准值，单位为mm' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EngineLib', @level2type=N'COLUMN',@level2name=N'wheelSizeB'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'总轴数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EngineLib', @level2type=N'COLUMN',@level2name=N'axleNum'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'所有机车型号的列表，如东风4、韶4、和谐3等等' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EngineLib'
GO
/****** Object:  UserDefinedFunction [dbo].[GetWord]    Script Date: 06/16/2015 14:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Shenxd
-- Create date: <Create Date,,>
-- Description:	查字典
-- =============================================
create FUNCTION [dbo].[GetWord]
(@word varchar(20))
RETURNS varchar(20)
AS

BEGIN
declare @ret varchar(20)
select @ret=cn from language where id=@word
if (isnull(@ret, '')='')
	set @ret = @word
RETURN @ret
END
GO
/****** Object:  StoredProcedure [dbo].[SelectCSDatas]    Script Date: 06/16/2015 14:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*************************************************************************************
作者：董辉
时间：2014-8-1 11:12
类型：新建
说明：根据条件查找擦伤数据
*************************************************************************************/

create proc [dbo].[SelectCSDatas]
(
	@in_QueryData nvarchar(max) --查询条件
)

as

begin

	begin try
	
		set NOCOUNT ON;
		
		if @in_QueryData <> ''
		
			BEGIN
			
				DECLARE @count int;
				
				declare @i int = 1;
				
				declare @j int = 1;
				
				declare @splittstr nvarchar(20);
				
				declare @currentstr nvarchar(20);
				
				declare @RunSQL nvarchar(Max) = '';
				
				declare @FileTable table([ID] int not null,[VALUE] nvarchar(255) not null);
				
				insert INTO @FileTable SELECT * from dbo.fun_SplitStrsToTable(@in_QueryData,'|');
				
				select @count = count(1) from @FileTable;
				
				while @i <= @count
					BEGIN
					
						select @splittstr = [VALUE] from @FileTable where [ID] = @i;
					
						if @i = 1
							BEGIN
							
								set @RunSQL += 'testDateTime = '''+@splittstr+''' and (';
							
							END
						ELSE
							BEGIN
							
							 select @currentstr = dbo.fun_SplitStr(@splittstr,',',1);
							 
							 if @j = 1
								BEGIN
								
									set @RunSQL += '(axleNo = '+@currentstr+'';
									
									select @currentstr = dbo.fun_SplitStr(@splittstr,',',2);
							 
									set @RunSQL += ' and wheelNo = '+@currentstr+') ';
								
								END
							 ELSE
								BEGIN
								
									set @RunSQL += 'or (axleNo = '+@currentstr+'';
									
									select @currentstr = dbo.fun_SplitStr(@splittstr,',',2);
							 
									set @RunSQL += ' and wheelNo = '+@currentstr+') ';
								
								END
								
								set @j += 1;

							END
						
						set @i+= 1;	
						
						
					END
					
				set @RunSQL = ' select AxleNo,
								wheelNo,
								swingNo,
								scratch_depth,
								scratch_length,
								X1,
								X2,
								XMax 
								from ScratchDetectResult 
								where ' + @RunSQL + ')';
				
				exec(@RunSQL);
			
			END
			
	end try
	
	begin catch
		
        DECLARE @ErrorMessage NVARCHAR(4000);

        DECLARE @ErrorSeverity INT;

        DECLARE @ErrorState INT;

        SELECT  @ErrorMessage = ERROR_MESSAGE(),
                @ErrorSeverity = ERROR_SEVERITY(),
                @ErrorState = ERROR_STATE();
        RAISERROR (@ErrorMessage,1,@ErrorState) WITH LOG;

        RETURN;
	
	end catch

end
GO
/****** Object:  UserDefinedFunction [dbo].[wheelPos]    Script Date: 06/16/2015 14:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[wheelPos]
(@czh varchar(50), @axleNo int ,@wheelNo int,@direction int)
RETURNS int
AS

BEGIN
declare @ret int
declare @trainType varchar(20)
declare @bz_dir int
declare @car int
declare @axleNum int


--动车
if (CHARINDEX('-',@czh) > 0)
	set @trainType= left(@czh,CHARINDEX('-',@czh)-1)
else
	set @trainType= 'CRH2' --默认车型

select	@axleNum = count(*)/2 from CRH_wheel where trainType=@trainType

if (@direction = 1)
	select @ret = wheelPos from CRH_wheel where trainType=@trainType and axleNo=@axleNo % @axleNum and wheelNo=@wheelNo
else
	select @ret = wheelPos from CRH_wheel where trainType=@trainType and axleNo=(@axleNum-(@axleNo%@axleNum)-1) and wheelNo=1-@wheelNo

return @ret



--客车机车
--set @axleNo = @axleNo % 4
--if (@direction = 1)
--	begin
--		set @ret = @axleNo*2 + 1
--		if (@wheelNo = 0)
--			set @ret = @ret +1
--	end
--else
--	begin
--		set @ret = (3-@axleNo)*2 + 1
--		if (@wheelNo = 1)
--			set @ret = @ret +1
--	end
--RETURN @ret
END
GO
/****** Object:  View [dbo].[V_engine]    Script Date: 06/16/2015 14:50:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create VIEW [dbo].[V_engine]
AS
SELECT     dbo.EngineLib.id, dbo.EngineLib.name, dbo.EngineLib.fullName, dbo.EngineLib.wheelSize, dbo.EngineLib.axleNum, 
                      dbo.FactoryLib.name AS factory_name, dbo.EngineTypeLib.name AS type_name, dbo.EngineLib.factoryId, dbo.EngineLib.typeId
FROM         dbo.EngineLib INNER JOIN
                      dbo.EngineTypeLib ON dbo.EngineLib.typeId = dbo.EngineTypeLib.id INNER JOIN
                      dbo.FactoryLib ON dbo.EngineLib.factoryId = dbo.FactoryLib.id
GO
/****** Object:  Table [dbo].[Engine]    Script Date: 06/16/2015 14:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Engine](
	[engNum] [varchar](50) NOT NULL,
	[id] [varchar](5) NULL,
	[engNumB] [varchar](12) NULL,
	[madeDate] [datetime] NULL,
	[wheelSize] [numeric](6, 2) NULL,
	[wheelSizeB] [numeric](6, 2) NULL,
 CONSTRAINT [PK_ENGINE] PRIMARY KEY CLUSTERED 
(
	[engNum] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'格式举例：DF4-1234' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Engine', @level2type=N'COLUMN',@level2name=N'engNum'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'目前A车的实际轮径值' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Engine', @level2type=N'COLUMN',@level2name=N'wheelSize'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'目前B车的实际轮径值' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Engine', @level2type=N'COLUMN',@level2name=N'wheelSizeB'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'所有在册机车的列表' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Engine'
GO
/****** Object:  Table [dbo].[Detect]    Script Date: 06/16/2015 14:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Detect](
	[testDateTime] [datetime] NOT NULL,
	[engNum] [varchar](50) NULL,
	[engBNum] [varchar](50) NULL,
	[engineDirection] [bit] NOT NULL,
	[bugNum] [smallint] NULL,
	[isView] [bit] NULL,
	[inSpeed] [numeric](5, 2) NULL,
	[outSpeed] [numeric](5, 2) NULL,
	[waterTemp] [numeric](5, 2) NULL,
	[temperature] [numeric](5, 2) NULL,
	[liquidTemp] [numeric](5, 2) NULL,
	[arrayATemp] [numeric](5, 2) NULL,
	[arrayBTemp] [numeric](5, 2) NULL,
	[redWheelNum] [smallint] NULL,
	[yellowWheelNum] [smallint] NULL,
	[blueWheelNum] [smallint] NULL,
	[greenWheelNum] [smallint] NULL,
	[isValid] [tinyint] NULL,
	[wheelSize] [numeric](6, 2) NULL,
	[wheelSizeB] [numeric](6, 2) NULL,
	[IsTypical] [bit] NULL,
	[AxleNum] [smallint] NULL,
	[scratchLevel3Num] [smallint] NULL,
	[scratchLevel2Num] [smallint] NULL,
	[scratchLevel1Num] [smallint] NULL,
	[scratchNum] [smallint] NULL,
	[M_LJ_Num] [smallint] NULL,
	[M_TmMh_Num] [smallint] NULL,
	[M_LyHd_Num] [smallint] NULL,
	[M_LwHd_Num] [smallint] NULL,
	[M_Ncj_Num] [smallint] NULL,
	[outDateTime] [datetime] NULL,
	[procUser] [varchar](50) NULL,
	[M_LyGd_Num] [smallint] NULL,
	[M_Qr_Num] [smallint] NULL,
	[videoScratchNum] [smallint] NULL,
 CONSTRAINT [PK_DETECT] PRIMARY KEY CLUSTERED 
(
	[testDateTime] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'与机车库中的车号相对应' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Detect', @level2type=N'COLUMN',@level2name=N'engNum'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'行进方向，
   True = 一机室在前
   False = 二机室在前
   ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Detect', @level2type=N'COLUMN',@level2name=N'engineDirection'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'是否已处理
   True = 已处理
   False = 未处理' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Detect', @level2type=N'COLUMN',@level2name=N'isView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'单位：公里/小时' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Detect', @level2type=N'COLUMN',@level2name=N'inSpeed'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'单位：公里/小时' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Detect', @level2type=N'COLUMN',@level2name=N'outSpeed'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'单位： 摄氏度' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Detect', @level2type=N'COLUMN',@level2name=N'waterTemp'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'单位： 摄氏度' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Detect', @level2type=N'COLUMN',@level2name=N'temperature'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'单位： 摄氏度' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Detect', @level2type=N'COLUMN',@level2name=N'liquidTemp'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'单位： 摄氏度' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Detect', @level2type=N'COLUMN',@level2name=N'arrayATemp'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'单位： 摄氏度' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Detect', @level2type=N'COLUMN',@level2name=N'arrayBTemp'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'所有的检测记录列表' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Detect'
GO
/****** Object:  View [dbo].[V_AllEngine]    Script Date: 06/16/2015 14:50:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[V_AllEngine]
AS
(SELECT     B.name, COUNT(*) AS amount
FROM         dbo.Engine AS E INNER JOIN
                      dbo.EngineLib AS B ON E.id = B.id
GROUP BY B.name)
union(select '总数' as name,count(*) as amount from Engine)
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "E"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 125
               Right = 196
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "B"
            Begin Extent = 
               Top = 6
               Left = 234
               Bottom = 125
               Right = 392
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'V_AllEngine'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'V_AllEngine'
GO
/****** Object:  Table [dbo].[WhmsTime]    Script Date: 06/16/2015 14:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WhmsTime](
	[tychoTime] [datetime] NOT NULL,
	[whmsTime] [datetime] NOT NULL,
 CONSTRAINT [PK_WhmsTime] PRIMARY KEY CLUSTERED 
(
	[tychoTime] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProfileDetectResult_real]    Script Date: 06/16/2015 14:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ProfileDetectResult_real](
	[testDateTime] [datetime] NOT NULL,
	[axleNo] [int] NOT NULL,
	[wheelNo] [tinyint] NOT NULL,
	[Lj] [numeric](5, 1) NULL,
	[TmMh] [numeric](5, 1) NULL,
	[LyHd] [numeric](5, 1) NULL,
	[LyGd] [numeric](5, 1) NULL,
	[LwHd] [numeric](5, 1) NULL,
	[LwHd2] [numeric](5, 1) NULL,
	[QR] [numeric](5, 1) NULL,
	[Ncj] [numeric](5, 1) NULL,
	[LjCha_Zhou] [numeric](5, 1) NULL,
	[LjCha_ZXJ] [numeric](5, 1) NULL,
	[LjCha_Che] [numeric](5, 1) NULL,
	[LjCha_Bz] [numeric](5, 1) NULL,
	[xmlFile] [varchar](50) NULL,
	[pos] [tinyint] NULL,
	[carPos] [tinyint] NULL,
	[carNo] [varchar](20) NULL,
	[Lj_user] [numeric](5, 1) NULL,
	[Lj_AVG] [numeric](5, 1) NULL,
	[LwHd2_AVG] [numeric](5, 1) NULL,
 CONSTRAINT [PK_ProfileDetectResult_real] PRIMARY KEY CLUSTERED 
(
	[testDateTime] ASC,
	[axleNo] ASC,
	[wheelNo] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ProfileDetectResult]    Script Date: 06/16/2015 14:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ProfileDetectResult](
	[testDateTime] [datetime] NOT NULL,
	[axleNo] [int] NOT NULL,
	[wheelNo] [tinyint] NOT NULL,
	[Lj] [numeric](5, 1) NULL,
	[TmMh] [numeric](5, 1) NULL,
	[LyHd] [numeric](5, 1) NULL,
	[LyGd] [numeric](5, 1) NULL,
	[LwHd] [numeric](5, 1) NULL,
	[LwHd2] [numeric](5, 1) NULL,
	[QR] [numeric](5, 1) NULL,
	[Ncj] [numeric](5, 1) NULL,
	[LjCha_Zhou] [numeric](5, 1) NULL,
	[LjCha_ZXJ] [numeric](5, 1) NULL,
	[LjCha_Che] [numeric](5, 1) NULL,
	[LjCha_Bz] [numeric](5, 1) NULL,
	[xmlFile] [varchar](50) NULL,
	[Level_lj] [tinyint] NULL,
	[Level_tmmh] [tinyint] NULL,
	[Level_lyhd] [tinyint] NULL,
	[Level_lwhd] [tinyint] NULL,
	[Level_ncj] [tinyint] NULL,
	[Level_lygd] [tinyint] NULL,
	[Level_qr] [tinyint] NULL,
	[Level_LjCha_Zhou] [tinyint] NULL,
	[Level_LjCha_ZXJ] [tinyint] NULL,
	[Level_LjCha_Che] [tinyint] NULL,
	[Level_LjCha_Bz] [tinyint] NULL,
 CONSTRAINT [PK_ProfileDetectResult] PRIMARY KEY CLUSTERED 
(
	[testDateTime] ASC,
	[axleNo] ASC,
	[wheelNo] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ScratchDetectResult]    Script Date: 06/16/2015 14:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ScratchDetectResult](
	[testDateTime] [datetime] NOT NULL,
	[axleNo] [int] NOT NULL,
	[wheelNo] [int] NOT NULL,
	[pos] [numeric](5, 1) NOT NULL,
	[temp] [nvarchar](50) NOT NULL,
	[scratch_depth] [float] NOT NULL,
	[scratch_length] [float] NOT NULL,
	[swingNo] [tinyint] NULL,
	[GX1] [int] NULL,
	[GX2] [int] NULL,
	[GXMax] [int] NULL,
	[GAX1] [int] NULL,
	[GAX2] [int] NULL,
	[GAXMax] [int] NULL,
	[X1] [int] NULL,
	[X2] [int] NULL,
	[XMax] [int] NULL,
	[level] [tinyint] NULL,
	[IsBug] [bit] NOT NULL,
	[reason] [varchar](160) NULL,
	[operator] [varchar](50) NULL,
	[R_CarNo] [nvarchar](50) NULL,
	[R_pos] [int] NULL,
	[R_level] [int] NULL,
 CONSTRAINT [PK_ScratchDetectResult] PRIMARY KEY CLUSTERED 
(
	[testDateTime] ASC,
	[axleNo] ASC,
	[wheelNo] ASC,
	[pos] ASC,
	[temp] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ProcData]    Script Date: 06/16/2015 14:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ProcData](
	[CommitTime] [datetime] NOT NULL,
	[testDateTime] [datetime] NOT NULL,
	[NeedProc] [tinyint] NOT NULL,
	[BeginTime] [datetime] NULL,
	[EndTime] [datetime] NULL,
	[UseNewWheelSize] [bit] NULL,
	[info] [varchar](50) NULL,
 CONSTRAINT [PK_ProcData] PRIMARY KEY CLUSTERED 
(
	[CommitTime] ASC,
	[testDateTime] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CheckTime]    Script Date: 06/16/2015 14:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CheckTime](
	[testDateTime] [datetime] NOT NULL,
	[userName] [varchar](50) NOT NULL,
	[checkTime] [datetime] NOT NULL,
 CONSTRAINT [PK_CheckTime] PRIMARY KEY CLUSTERED 
(
	[testDateTime] ASC,
	[userName] ASC,
	[checkTime] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[VideoScratchDetectResult]    Script Date: 06/16/2015 14:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VideoScratchDetectResult](
	[testDateTime] [datetime] NOT NULL,
	[axleNo] [int] NOT NULL,
	[wheelNo] [tinyint] NOT NULL,
	[level] [tinyint] NULL,
 CONSTRAINT [PK_VideoScratchDetectResult] PRIMARY KEY CLUSTERED 
(
	[testDateTime] ASC,
	[axleNo] ASC,
	[wheelNo] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Sequ]    Script Date: 06/16/2015 14:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sequ](
	[testDateTime] [datetime] NOT NULL,
	[axleNo] [smallint] NOT NULL,
	[wheelNo] [tinyint] NOT NULL,
	[status1] [tinyint] NULL,
	[status2] [tinyint] NULL,
	[status3] [tinyint] NULL,
	[status4] [tinyint] NULL,
 CONSTRAINT [PK_Sequ] PRIMARY KEY CLUSTERED 
(
	[testDateTime] ASC,
	[axleNo] ASC,
	[wheelNo] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Diameter]    Script Date: 06/16/2015 14:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Diameter](
	[testDateTime] [datetime] NOT NULL,
	[axleNo] [smallint] NOT NULL,
	[wheelNo] [tinyint] NOT NULL,
	[WheelSize] [numeric](5, 1) NOT NULL,
 CONSTRAINT [PK_Diameter] PRIMARY KEY CLUSTERED 
(
	[testDateTime] ASC,
	[axleNo] ASC,
	[wheelNo] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[FindIsTypicalData]    Script Date: 06/16/2015 14:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*************************************************************************************
作者：董辉
时间：2014-8-22 9:41
类型：新建
说明：根据选取的文件名称确定是否可再次分析
*************************************************************************************/
create proc [dbo].[FindIsTypicalData]
(
	@in_DateTimes nvarchar(max)
)

as

begin

	begin try
	
		set NOCOUNT ON;
		
		if @in_DateTimes <> ''
			BEGIN
			
				--定义最终查询结果表变量
				declare @RecordTable table([FileName] nvarchar(100) not null,[IsTypical] bit not null);
				
				--定义临时查询内容表变量
				declare @FileTable table([ID] int not null,[VALUE] nvarchar(100) not null);
				
				--定义数量
				declare @count int = 0;
				
				--是否可再次分析
				declare @isAgainChk bit = 0;
				
				--定义循环因子
				declare @i int = 1;
				
				--定义当前文件名称
				declare @DateFileName nvarchar(100) = '';
				
				--分割文件名称到临时查询内容表变量中
				insert INTO @FileTable SELECT * from dbo.fun_SplitStrsToTable(@in_DateTimes,',');
				
				--获取数量
				select @count = count(1) from @FileTable;
				
				while @i <= @count
					BEGIN
					
						--找第i个待检测的文件名称
						select @DateFileName = [VALUE] from @FileTable where [ID] = @i;
						
						--根据文件名称检测此文件是否可再次分析
						select @isAgainChk = IsTypical from Detect where testDateTime = @DateFileName;
						
						--存储到结果表变量中
						insert into @RecordTable values(@DateFileName,@isAgainChk);
						
						set @i += 1;
					
					END
					
				--查询结果表
				select * from @RecordTable;
			
			END
		
	end  try
	
	begin catch
	
		DECLARE @ErrorMessage NVARCHAR(4000);

        DECLARE @ErrorSeverity INT;

        DECLARE @ErrorState INT;

        SELECT  @ErrorMessage = ERROR_MESSAGE(),
                @ErrorSeverity = ERROR_SEVERITY(),
                @ErrorState = ERROR_STATE();
        RAISERROR (@ErrorMessage,1,@ErrorState) WITH LOG;

        RETURN;
	
	end catch

end
GO
/****** Object:  StoredProcedure [dbo].[FindCSDynamicLevel]    Script Date: 06/16/2015 14:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**********************************************************************************************
-- 创建：董辉
-- 时间：2014-9-17 9:17
-- 说明：数据库中查找对应编组的擦伤等级定义数据
**********************************************************************************************/
create proc [dbo].[FindCSDynamicLevel]
(
	@in_testDateTime datetime --检测时间
)

as

begin

	set NOCOUNT on;
	
	begin TRY
	
		--转换后的编组号
		declare @EngNum nvarchar(50);
		
		select 
			@EngNum = dbo.TransformEngNum(engNum) 
		from 
			Detect 
		where 
			testDateTime = @in_testDateTime;
			
		if @EngNum <> '未知'
			BEGIN
			
				select 
					up_level1,
					up_level2,
					up_level3 
				from 
					thresholds 
				where 
					trainType = @EngNum
				and 
					name = 'CS_SD'
			
			END
		ELSE
			BEGIN
			
				select 
					up_level1,
					up_level2,
					up_level3 
				from 
					thresholds 
				where 
					trainType = 'default' 
				and 
					name = 'CS_SD';
			
			END
	
	end TRY
	
	begin CATCH
	
		DECLARE @ErrorMessage NVARCHAR(4000);

        DECLARE @ErrorSeverity INT;

        DECLARE @ErrorState INT;

        SELECT  @ErrorMessage = ERROR_MESSAGE(),
                @ErrorSeverity = ERROR_SEVERITY(),
                @ErrorState = ERROR_STATE();
        RAISERROR (@ErrorMessage,1,@ErrorState) WITH LOG;

        RETURN;
	
	end CATCH

end
GO
/****** Object:  UserDefinedFunction [dbo].[GetWheelPos_By_TestDateTime_AxleNo_WheelNo]    Script Date: 06/16/2015 14:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Shenxd
-- Create date: <Create Date,,>
-- Description:	由检测时间、检测轴号、左右位置获取轮位
-- =============================================
CREATE FUNCTION [dbo].[GetWheelPos_By_TestDateTime_AxleNo_WheelNo]
(@testDateTime datetime, @axleNo int ,@wheelNo int)
RETURNS int
AS

BEGIN
declare @ret int
declare @trainType varchar(20)
declare @direction int
declare @car int
declare @axleNum int
declare @czh varchar(50)

--动车

select @czh=engnum,  @direction=engineDirection  from detect where testdatetime=@testDateTime

set @trainType = ''
if (CHARINDEX('-',@czh) > 0)
	set @trainType= left(@czh,CHARINDEX('-',@czh)-1)
if ((@trainType = '') or (@trainType = 'unknown'))
	set @trainType= 'CRH2' --默认车型

select	@axleNum = count(*)/2 from CRH_wheel where trainType=@trainType

if (@direction = 1)
	select @ret = wheelPos from CRH_wheel where trainType=@trainType and axleNo=@axleNo % @axleNum and wheelNo=@wheelNo
else
	select @ret = wheelPos from CRH_wheel where trainType=@trainType and axleNo=(@axleNum-(@axleNo%@axleNum)-1) and wheelNo=1-@wheelNo

return @ret



--客车机车
--set @axleNo = @axleNo % 4
--if (@direction = 1)
--	begin
--		set @ret = @axleNo*2 + 1
--		if (@wheelNo = 0)
--			set @ret = @ret +1
--	end
--else
--	begin
--		set @ret = (3-@axleNo)*2 + 1
--		if (@wheelNo = 1)
--			set @ret = @ret +1
--	end
--RETURN @ret
END
GO
/****** Object:  Table [dbo].[CSSequ]    Script Date: 06/16/2015 14:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CSSequ](
	[testDateTime] [datetime] NOT NULL,
	[axleNo] [smallint] NOT NULL,
	[status1] [tinyint] NULL,
	[status2] [tinyint] NULL,
	[status3] [tinyint] NULL,
 CONSTRAINT [PK_CSSequ] PRIMARY KEY CLUSTERED 
(
	[testDateTime] ASC,
	[axleNo] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CarList]    Script Date: 06/16/2015 14:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CarList](
	[testDateTime] [datetime] NOT NULL,
	[posNo] [tinyint] NOT NULL,
	[carNo] [varchar](20) NOT NULL,
	[carNo2] [varchar](20) NULL,
 CONSTRAINT [PK_CarList] PRIMARY KEY CLUSTERED 
(
	[testDateTime] ASC,
	[posNo] ASC,
	[carNo] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[BugResult]    Script Date: 06/16/2015 14:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[BugResult](
	[testDateTime] [datetime] NOT NULL,
	[axleNo] [tinyint] NOT NULL,
	[wheelNo] [tinyint] NOT NULL,
	[pos_angle] [numeric](5, 2) NOT NULL,
	[pos_deep] [numeric](5, 2) NOT NULL,
	[level] [tinyint] NULL,
	[num_double] [tinyint] NULL,
	[num_single] [tinyint] NULL,
	[num_angle] [tinyint] NULL,
	[desc] [varchar](100) NULL,
	[IsBug] [bit] NULL,
	[reason] [varchar](160) NULL,
	[operator] [varchar](20) NULL,
	[desc2] [varchar](max) NULL,
 CONSTRAINT [PK_BUGRESULT] PRIMARY KEY CLUSTERED 
(
	[testDateTime] ASC,
	[axleNo] ASC,
	[wheelNo] ASC,
	[pos_angle] ASC,
	[pos_deep] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'轮对号（从1开始）' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BugResult', @level2type=N'COLUMN',@level2name=N'axleNo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'0＝左轮 1＝右轮' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BugResult', @level2type=N'COLUMN',@level2name=N'wheelNo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'缺陷所在位置的角度，相对于标记位置，顺时针方向(0~360度)
   视角都是从外向内看
   ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BugResult', @level2type=N'COLUMN',@level2name=N'pos_angle'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'缺陷到轮边缘的深度(mm)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BugResult', @level2type=N'COLUMN',@level2name=N'pos_deep'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'缺陷类型(0-无缺陷，1-红色报警，2-黄色报警，3-蓝色报警)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BugResult', @level2type=N'COLUMN',@level2name=N'level'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'探伤结果的文字性描述' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BugResult', @level2type=N'COLUMN',@level2name=N'desc'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'每条记录对应一个物理缺陷。
   物理缺陷是对所有探头缺陷的分析总结结果。
   对于一次检测，可能存在多个物理缺陷，也可能没有物理缺陷。 
   对于一个物理缺陷，可能由多个探头同时探测到
   ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BugResult'
GO
/****** Object:  Table [dbo].[Bug]    Script Date: 06/16/2015 14:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Bug](
	[testDateTime] [datetime] NOT NULL,
	[axleNo] [smallint] NOT NULL,
	[wheelNo] [tinyint] NOT NULL,
	[detectorType] [tinyint] NOT NULL,
	[detectorNo] [smallint] NOT NULL,
	[level] [tinyint] NOT NULL,
	[boGao] [numeric](5, 2) NULL,
	[distance] [numeric](5, 2) NULL,
	[pos_angle] [numeric](5, 2) NOT NULL,
	[pos_deep] [numeric](6, 2) NOT NULL,
	[Single_dir] [tinyint] NULL,
	[Single_pos] [tinyint] NULL,
 CONSTRAINT [PK_BUG] PRIMARY KEY CLUSTERED 
(
	[testDateTime] ASC,
	[axleNo] ASC,
	[wheelNo] ASC,
	[detectorType] ASC,
	[detectorNo] ASC,
	[level] ASC,
	[pos_angle] ASC,
	[pos_deep] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'轮对号（从1开始）' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Bug', @level2type=N'COLUMN',@level2name=N'axleNo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'车轮位置（0-左侧，1-右侧）' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Bug', @level2type=N'COLUMN',@level2name=N'wheelNo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'探头种类
   1＝双晶直探头
   2＝单晶斜探头
   3＝小角度直探头
   ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Bug', @level2type=N'COLUMN',@level2name=N'detectorType'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'探头号（从1开始）' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Bug', @level2type=N'COLUMN',@level2name=N'detectorNo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'缺陷类型(0-无报警，1-蓝色报警，2-黄色报警，3-红色报警)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Bug', @level2type=N'COLUMN',@level2name=N'level'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'最大波高' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Bug', @level2type=N'COLUMN',@level2name=N'boGao'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'单位：mm' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Bug', @level2type=N'COLUMN',@level2name=N'distance'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'缺陷所在位置的角度，相对于标记位置，顺时针方向(0~360度)
   视角都是从外向内看
   ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Bug', @level2type=N'COLUMN',@level2name=N'pos_angle'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'缺陷到轮边缘的深度(mm)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Bug', @level2type=N'COLUMN',@level2name=N'pos_deep'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'单晶斜探头方向，0顺时针 1逆时针' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Bug', @level2type=N'COLUMN',@level2name=N'Single_dir'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'通常为1，2，或3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Bug', @level2type=N'COLUMN',@level2name=N'Single_pos'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'每条记录对应一个探头缺陷。对于一次检测，可能存在多个缺陷，也可能没有缺陷' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Bug'
GO
/****** Object:  StoredProcedure [dbo].[CopyCarNoDestSource]    Script Date: 06/16/2015 14:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Shenxd
-- Create date: 2014.11.6
-- Description:	车号复制
-- =============================================
CREATE PROCEDURE [dbo].[CopyCarNoDestSource] 
@destTestTime datetime, @sourceTestTime datetime
--WITH ENCRYPTION
AS
declare @cursor_test cursor
declare @pos int
declare @carNo varchar(20)
declare @bzh varchar(50)
BEGIN
	SET NOCOUNT ON;
    select @bzh=engNum from Detect where testDateTime=@sourceTestTime
    update Detect set engNum=@bzh where testDateTime=@destTestTime    
	set @cursor_test = cursor for select posNo,carNo from carlist where testDateTime=@sourceTestTime
	open @cursor_test 
	delete from CarList where testDateTime=@destTestTime
	fetch next from @cursor_test into @pos, @carNo
	while(@@fetch_status=0)
	begin
		insert into CarList(testDateTime,posNo,carNo,carNo2) values(@destTestTime, @pos, @carNo, null)
		fetch next from @cursor_test into @pos, @carNo
	end
	--重算目标数据
	exec [BaseWhprP807].[dbo].[uphistory2] @destTestTime
END
GO
/****** Object:  StoredProcedure [dbo].[GetLastData]    Script Date: 06/16/2015 14:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetLastData] 
@carNo char(20),
@wheelPos int
--WITH ENCRYPTION
AS
declare @AxleNum int
declare @dir int
BEGIN

--select @AxleNum = axleNum,@dir=engineDirection  from detect where testdatetime=@mDateTime

select top 1 testDateTime, axleNo, wheelNo, CarNo, pos, Lj_user as Lj, TmMh,LyHd, LyGd, LwHd, QR, Ncj 
from ProfileDetectResult_real
where CarNo=@carNo and pos=@wheelPos
order by testDateTime desc

END
GO
/****** Object:  StoredProcedure [dbo].[GetData_wx]    Script Date: 06/16/2015 14:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Shenxd
-- Create date: <Create Date,,>
-- Description:	取外形数据，上传信息系统用
-- =============================================
CREATE PROCEDURE [dbo].[GetData_wx] 
@mDateTime char(20)
--WITH ENCRYPTION
AS
declare @AxleNum int
declare @dir int
declare @bzh varchar(20)
BEGIN

select @bzh=engNum,@AxleNum = axleNum, @dir=engineDirection  from detect where testdatetime=@mDateTime


SELECT   A.axleNo, A.wheelNo, A.axleNo/4 carIndex, dbo.wheelPos(@bzh,A.axleNo, A.wheelNo, @dir) Pos, D.Lj,D.TmMh,D.LyHd,D.LyGd,D.LwHd,D.Qr,D.Ncj,D.level_lj,D.level_TmMh,D.level_LyHd,D.level_LyGd,D.level_LwHd,D.level_Qr,D.level_Ncj,E.carNo FROM
                (select * from FullAxle_all where axleno< @AxleNum) A 
                 left join 
                (select * from ProfileDetectResult where testDateTime = @mDateTime) D
                on A.axleNo = D.axleNo AND A.wheelNo = D.wheelNo 
                left join
                (select * from carlist where testDateTime = @mDateTime) E
                on A.axleNo/4 = E.posNo  
                order by carindex,Pos
END
GO
/****** Object:  StoredProcedure [dbo].[GetData_TS]    Script Date: 06/16/2015 14:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Shenxd
-- Create date: <Create Date,,>
-- Description:	取探伤数据，上传信息系统用
-- =============================================
CREATE PROCEDURE [dbo].[GetData_TS] 
@mDateTime char(20)
--WITH ENCRYPTION
AS
declare @AxleNum int
declare @dir int
declare @bzh varchar(20)
BEGIN

select @bzh=engNum, @AxleNum = axleNum, @dir=engineDirection  from detect where testdatetime=@mDateTime

SELECT  A.axleNo, A.wheelNo, A.axleNo/4 carIndex, dbo.wheelPos(@bzh, A.axleNo, A.wheelNo, @dir) Pos, B.axleno sAxle, B.*,E.carNo FROM
                (select * from FullAxle_all where axleno< @AxleNum) A 
                 left join 
                (select * from BugResult where testDateTime = @mDateTime and isbug=1 and level<=3) B
				on A.axleNo = B.axleNo AND A.wheelNo = B.wheelNo 
                left join
                (select * from carlist where testDateTime = @mDateTime) E
                on A.axleNo/4 = E.posNo  
                order by carindex,Pos
END
GO
/****** Object:  StoredProcedure [dbo].[GetData_CS]    Script Date: 06/16/2015 14:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Shenxd
-- Create date: <Create Date,,>
-- Description:	取擦伤数据，上传信息系统用
-- =============================================
CREATE PROCEDURE [dbo].[GetData_CS] 
@mDateTime char(20)
--WITH ENCRYPTION
AS
declare @AxleNum int
declare @dir int
declare @bzh varchar(20)
BEGIN

select @bzh=engNum, @AxleNum = axleNum, @dir=engineDirection  from detect where testdatetime=@mDateTime


SELECT   A.axleNo, A.wheelNo, A.axleNo/4 carIndex, dbo.wheelPos(@bzh, A.axleNo, A.wheelNo, @dir) Pos, B.axleno sAxle,B.*,E.carNo FROM
                (select * from FullAxle_all where axleno< @AxleNum) A 
                 left join 
                (select axleno, wheelno, level,scratch_depth,scratch_length from scratchDetectResult where testDateTime = @mDateTime and isbug=1) B
				on A.axleNo = B.axleNo AND A.wheelNo = B.wheelNo 
                left join
                (select * from carlist where testDateTime = @mDateTime) E
                on A.axleNo/4 = E.posNo  
                order by carindex,Pos
END
GO
/****** Object:  UserDefinedFunction [dbo].[GetAxleNo_By_TestDateTime_CarNo_WheelPos]    Script Date: 06/16/2015 14:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Shenxd
-- Create date: <Create Date,,>
-- Description:	由检测时间、车厢号、轮位获取检测轴号号
-- =============================================
CREATE FUNCTION [dbo].[GetAxleNo_By_TestDateTime_CarNo_WheelPos]
(@testDateTime datetime, @carNo varchar(20) ,@wheelPos int)
RETURNS int
AS

BEGIN
declare @ret int
declare @trainType varchar(20)
declare @direction int
declare @carPos int
declare @partCarPos int
declare @axleNum int
declare @czh varchar(50)

--动车

select @czh=engnum,  @direction=engineDirection  from detect where testdatetime=@testDateTime

if (CHARINDEX('-',@czh) > 0)
	set @trainType= left(@czh,CHARINDEX('-',@czh)-1)
else
	set @trainType= 'CRH2' --默认车型
	

	
select @carPos=posNo from carlist where testdatetime=@testDateTime and carNo=@carNo


select	@axleNum = count(*)/2 from CRH_wheel where trainType=@trainType

--单编组中的车厢相对位置
set @partCarPos = @carPos % (@axleNum / 4)

if (@direction = 1)
	select @ret = axleNo from CRH_wheel where trainType=@trainType and axleNo>=@partCarPos*4 and axleNo<@partCarPos*4+4 and wheelPos=@wheelPos
else
	select @ret = @axleNum-axleNo-1 from CRH_wheel where trainType=@trainType and axleNo>=@axleNum - @partCarPos*4 -4 and axleNo<@axleNum - @partCarPos*4 and wheelPos=@wheelPos

set @ret=@ret+(@carPos /(@axleNum / 4))*@axleNum

return @ret



--客车机车
--set @axleNo = @axleNo % 4
--if (@direction = 1)
--	begin
--		set @ret = @axleNo*2 + 1
--		if (@wheelNo = 0)
--			set @ret = @ret +1
--	end
--else
--	begin
--		set @ret = (3-@axleNo)*2 + 1
--		if (@wheelNo = 1)
--			set @ret = @ret +1
--	end
--RETURN @ret
END
GO
/****** Object:  StoredProcedure [dbo].[Get_LWHD]    Script Date: 06/16/2015 14:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Get_LWHD] 
AS
declare @tychoTime datetime
declare @whmsTime datetime
declare @id int
declare @axleNo int
declare @wheel_side varchar(21)
declare @wheelNo tinyint
declare @diameter float
declare @hollow_tread float
declare @flange_width float
declare @flange_height float
declare @value float
declare @rim_thickness float
declare @back_to_back_gauge float
declare @xmlFile varchar(50)
declare @cursor_test cursor 
declare @cursor_wheel cursor 

BEGIN
	SET NOCOUNT ON;
	
	set @cursor_test = cursor for select testDateTime from detect order by testDateTime desc
	open @cursor_test
	fetch next from @cursor_test into @tychoTime
	while(@@fetch_status=0)
	begin
	print '------------------'
	print @tychoTime
		select @whmsTime=WhmsTime from WhmsTime where tychoTime=@tychoTime
		if (@@rowcount=1)
		begin
		print  @whmsTime
		print convert(varchar, @whmsTime,120)
			select @id=id from BaseWhprP807.dbo.train where datetime_start=@whmsTime
					print 'ID:'
					print @id
			if (@id > 0 )
				begin
					--select @id=id from BaseWhprP807.dbo.train where datetime_start=@tychoTime

					set @cursor_wheel = cursor for select axleNo,wheelNo from profileDetectResult where testDateTime=@tychoTime
					open @cursor_wheel
					fetch next from @cursor_wheel into @axleNo,@wheelNo
					while(@@fetch_status=0)
					begin
						if (@wheelNo = 0)
							set @wheel_side = 'LEFT'
						else
							set @wheel_side = 'RIGHT'
							
						select @value=rim_thickness from BaseWhprP807.dbo.wheels where train_id=@id and axle_wpms_sequence=@axleNo and wheel_side=@wheel_side
					    --print @axleNo
						update ProfileDetectResult set LwHd2 = @value where testDateTime=@tychoTime and axleNo=@axleNo and wheelNo=@wheelNo
						fetch next from @cursor_wheel into @axleNo,@wheelNo
					end
					close @cursor_wheel
					deallocate @cursor_wheel
				end
			else
				begin
				print 'No Id'	
				print @id
				end
			
		end
		else
			print 'No Find'
		fetch next from @cursor_test into @tychoTime
	end
	close @cursor_test
	deallocate @cursor_test
END
GO
/****** Object:  UserDefinedFunction [dbo].[GetCarNoByAxleNo]    Script Date: 06/16/2015 14:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Shenxd
-- Create date: <Create Date,,>
-- Description:	由检测时间和轴号获取车厢号
-- =============================================
create FUNCTION [dbo].[GetCarNoByAxleNo]
(@testdatetime datetime ,@axleNo int)
RETURNS varchar(20)
AS

BEGIN
declare @ret varchar(20)

select @ret=carNo from carlist where testdatetime=@testdatetime and posNo=@axleNo/4

RETURN isnull(@ret, '-')
END
GO
/****** Object:  StoredProcedure [dbo].[GetCar]    Script Date: 06/16/2015 14:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Shenxd
-- Create date: 2014-0902
-- Description:	单车厢历史检测
-- =============================================
CREATE PROCEDURE [dbo].[GetCar] 
@mDateTime char(20),
@carIndex int
--WITH ENCRYPTION
AS
declare @AxleNum int
declare @dir int
declare @trainType varchar(20)
--擦伤级别
declare @cs int
--视频擦伤级别
declare @vcs int
--擦伤级别文本
declare @Fcs varchar(20)
--视频擦伤级别文本
declare @Fvcs varchar(20)
declare @L0 varchar(20)
declare @L1 varchar(20)
declare @L2 varchar(20)
declare @L3 varchar(20)
declare @L4 varchar(20)

--升级三级不显示的时刻
declare @upgradeTime datetime
BEGIN

select @upgradeTime= dbo.GetUpgradeTime()


set @L0 = dbo.GetWord('无')
set @L1 = dbo.GetWord('I')
set @L2 = dbo.GetWord('II')
if (@mDateTime < @upgradeTime)
	set @L3 = 'III'
else
	set @L3 = dbo.GetWord('III')
set @L4 = dbo.GetWord('IIII')


select @trainType=engNum, @AxleNum = axleNum,@dir=engineDirection ,@cs=isnull(scratchNum, - 1),  @vcs=isnull(videoScratchNum, - 1)
from detect 
where testdatetime=@mDateTime

if (@cs = -1)
	set @Fcs = '-'
else
	set @Fcs = @L0
if (@vcs = -1)
	set @Fvcs = '-'
else
	set @Fvcs = @L0

SELECT   A.axleNo, A.wheelNo, dbo.carPos(@carIndex, @AxleNum/4, @dir) carPos,
 dbo.wheelPos(@trainType, A.axleNo+@carIndex*4, A.wheelNo, @dir) Pos,
isnull(str(B.level),0) level,
case isnull(B.level,0) when 0 then @L0 when 1 then @L1  when 2 then @L2 when 3 then @L3 when 4 then @L4 end as sLevel_ts,
isnull(str(C.cslevel),0) cslevel,
case isnull(C.cslevel,0) when 0 then @Fcs when 1 then @L1  when 2 then @L2 when 3 then @L3 when 4 then @L4 end as sLevel_cs,
isnull(str(V.vcslevel),0) vcslevel,
case isnull(V.vcslevel,0) when 0 then @Fvcs when 1 then @L1  when 2 then @L2 when 3 then @L3 when 4 then @L4 end as sLevel_vcs,
isnull(str(D.Lj,5,1),'-') Lj,isnull(str(D.TmMh,5,1),'-') TmMh,isnull(str(D.LyHd,5,1),'-') LyHd,isnull(str(D.LyGd,5,1),'-') LyGd,
isnull(str(D.LwHd,5,1),'-') LwHd,isnull(str(D.Qr,5,1),'-') Qr,isnull(str(D.Ncj,6,1),'-') Ncj,isnull(str(D.LjCha_Zhou,6,1),'-') LjCha_Zhou,
isnull(str(D.LjCha_ZXJ,6,1),'-') LjCha_ZXJ, isnull(str(D.LjCha_Che,6,1),'-') LjCha_Che,isnull(str(D.LjCha_Bz,6,1),'-') LjCha_Bz, 
isnull(D.Level_lj, 4) Level_lj,isnull(D.Level_LjCha_Bz, 4) Level_LjCha_Bz,isnull(D.Level_LjCha_Che, 4) Level_LjCha_Che,
isnull(D.Level_LjCha_Zhou, 4) Level_LjCha_Zhou,isnull(D.Level_LjCha_ZXJ, 4) Level_LjCha_ZXJ,isnull(D.Level_lwhd, 4) Level_lwhd,
isnull(D.Level_lygd, 4) Level_lygd,isnull(D.Level_lyhd, 4) Level_lyhd,isnull(D.Level_ncj, 4) Level_ncj,isnull(D.Level_qr, 4) Level_qr,
isnull(D.Level_tmmh, 4) Level_tmmh,

E.status1, E.status2, E.status3, E.status4, F.status1 csStatus1, F.status2 csStatus2, F.status3 csStatus3 
FROM
                (select * from FullAxle1) A 
                 left join 
                (select axleno, wheelno, min(level) as level from bugresult where testdatetime=@mDateTime group by axleno, wheelno) B  
                on A.axleNo + @carIndex*4 = B.axleNo AND A.wheelNo = B.wheelNo
                left join
                (select axleno, wheelno, min(level) as cslevel from scratchDetectResult where testDateTime = @mDateTime group by axleno, wheelno) C
                on A.axleNo+ @carIndex*4 = C.axleNo AND A.wheelNo = C.wheelNo
                left join
                (select axleno, wheelno, min(level) as vcslevel  from VideoScratchDetectResult where testDateTime = @mDateTime group by axleno, wheelno) V
                on A.axleNo = V.axleNo AND A.wheelNo = V.wheelNo
                left join
                (select * from ProfileDetectResult where testDateTime = @mDateTime) D
                on A.axleNo+ @carIndex*4 = D.axleNo AND A.wheelNo = D.wheelNo 
                left join
                (select * from Sequ where testDateTime = @mDateTime) E
                on A.axleNo+ @carIndex*4 = E.axleNo AND A.wheelNo = E.wheelNo 
                left join
                (select * from CSSequ where testDateTime = @mDateTime) F
                on A.axleNo+ @carIndex*4 = F.axleNo 
                order by Pos
END
GO
/****** Object:  StoredProcedure [dbo].[FilterCSByCoincidenceLocation]    Script Date: 06/16/2015 14:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**********************************************************************************************
-- 创建：董辉
-- 时间：2014-9-14 13:19
-- 说明：过滤多个轮子在同一摆杆位置有重合的伤数据
**********************************************************************************************/

create proc [dbo].[FilterCSByCoincidenceLocation]
(
	@in_TestDateTime datetime, --检测时间
	
	@in_EncoderModel int	   --编码模式（0：双编码，1：单编码）
)

as

begin

	--不返回受影响行数
	set nocount on;
	
	begin try
		
		--当前列车有伤时过滤
		if exists(select testDateTime from ScratchDetectResult where testDateTime = @in_TestDateTime)
			begin
			
					--定义变量
					declare @LeftIndex		   int = 1,		--左轮循环因子
							@NextLeftIndex	   int = 1,		--下一左轮循环因子
							@RightIndex		   int = 1,		--右轮循环因子
							@NextRightIndex	   int = 1,		--下一右轮循环因子
							@EncoderIndex	   int,			--确定编码器号循环因子
							@CSLeftTotalCount  int,			--左轮擦伤总行数
							@CSRightTotalCount int,		    --右轮擦伤总行数
							@CurrentTemp	   nvarchar(50),--当前轮子的GUID唯一号
							@NextTemp		   nvarchar(50),--下一轮子的GUID唯一号
						    @CurrentStartIndex int,			--定义当前轮子擦伤的开始位置
							@CurrrentEndIndex  int,			--定义当前轮子擦伤的结束位置
							@NextStartIndex	   int,			--定义下一轮子擦伤的开始位置
							@NextEndIndex	   int;			--定义下一轮子擦伤的结束位置
					
					--定义左轮表对象
					declare @CSLeftTable table(
												  [ID] int IDENTITY(1, 1) not null,
												  [temp] nvarchar(50) not null,
												  [X1] int not null,
												  [X2] int not null,
												  [swingNo] tinyint
											   );
											   
					--定义右轮表对象
					declare @CSRightTable table(
												  [ID] int IDENTITY(1, 1) not null,
												  [temp] nvarchar(50) not null,
												  [X1] int not null,
												  [X2] int not null,
												  [swingNo] tinyint
											   );
											   
					--插入左轮擦伤表数据
					insert into @CSLeftTable select [temp],[X1],[X2],[swingNo] from ScratchDetectResult 
											 where testDateTime = @in_TestDateTime and wheelNo = 0 
											 order by swingNo asc;
											 
					--插入右轮擦伤表数据
					insert into @CSRightTable select [temp],[X1],[X2],[swingNo] from ScratchDetectResult 
											 where testDateTime = @in_TestDateTime and wheelNo = 1
											 order by swingNo asc;
											 
					--获取左轮擦伤数据行数
					select @CSLeftTotalCount = COUNT(1) from @CSLeftTable;
					
					--获取右轮擦伤数据行数
					select @CSRightTotalCount = COUNT(1) from @CSRightTable;
					
					--双编码
					if @in_EncoderModel = 0
						BEGIN
						
							--检测左轮是否有擦伤
							if exists(select * from @CSLeftTable)
								begin
								
									--初始化编码器为左轮的循环因子
									set @EncoderIndex = 0;
									
									--循环当前轮子
									while @LeftIndex <= @CSLeftTotalCount
										begin
										
											--循环摆杆
											while @EncoderIndex <= 10
												begin
												
													--获取当前轮子指定摆杆的擦伤开始、结束位置
													select @CurrentStartIndex = X1,
														   @CurrrentEndIndex = X2,
														   @CurrentTemp = temp
													from   @CSLeftTable 
													where  [ID] = @LeftIndex 
													and 
													(
														   [swingNo] = @EncoderIndex 
														or 
														   [swingNo] = (@EncoderIndex + 2)
													);
													
													--循环剩余所有轮子
													while @NextLeftIndex <= @CSLeftTotalCount
														begin
														
															--获取下一轮子指定摆杆的擦伤开始、结束位置
															select @NextStartIndex = X1,
																   @NextEndIndex = X2,
																   @NextTemp = temp
															from   @CSLeftTable 
															where  [ID] = @NextLeftIndex 
															and 
															(
																   [swingNo] = @EncoderIndex 
																or 
																   [swingNo] = (@EncoderIndex + 2)
															);
															
															--下一轮子与当前轮子不是同一条数据
															if @NextTemp <> '' and @NextTemp <> @CurrentTemp
																begin
																
																	if @NextStartIndex <= @CurrrentEndIndex and @NextEndIndex >= @CurrentStartIndex
																		begin
																		
																			update ScratchDetectResult 
																			set level = 4 
																			where 
																				temp = @NextTemp
																				or
																				temp = @CurrentTemp;
																		
																		end
																
																end

															set @NextTemp = '';
															
															set @NextLeftIndex += 1;
														
														end
														
													set @NextLeftIndex = 1;
													
													set @EncoderIndex += 4;
												
												end
											
											set @EncoderIndex = 0;
											
											set @LeftIndex += 1;
										
										end
									
								end
								
							--重置变量
							set @CurrentStartIndex = 0;
							set @CurrrentEndIndex = 0;
							set @CurrentTemp = '';
							set @NextStartIndex = 0;
							set @NextEndIndex = 0;
							set @NextTemp = '';
							
							--检测右轮是否有擦伤
							if exists(select * from @CSRightTable)
								begin
								
									--初始化编码器为左轮的循环因子
									set @EncoderIndex = 1;
									
									--循环当前轮子
									while @RightIndex <= @CSRightTotalCount
										begin
										
											--循环摆杆
											while @EncoderIndex <= 11
												begin
												
													--获取当前轮子指定摆杆的擦伤开始、结束位置
													select @CurrentStartIndex = X1,
														   @CurrrentEndIndex = X2,
														   @CurrentTemp = temp
													from   @CSRightTable 
													where  [ID] = @RightIndex 
													and 
													(
														   [swingNo] = @EncoderIndex 
														or 
														   [swingNo] = (@EncoderIndex + 2)
													);
													
													--循环剩余所有轮子
													while @NextRightIndex <= @CSRightTotalCount
														begin
														
															--获取下一轮子指定摆杆的擦伤开始、结束位置
															select @NextStartIndex = X1,
																   @NextEndIndex = X2,
																   @NextTemp = temp
															from   @CSRightTable 
															where  [ID] = @NextRightIndex 
															and 
															(
																   [swingNo] = @EncoderIndex 
																or 
																   [swingNo] = (@EncoderIndex + 2)
															);
															
															--下一轮子与当前轮子不是同一条数据
															if @NextTemp <> '' and @NextTemp <> @CurrentTemp
																begin
																
																	if @NextStartIndex <= @CurrrentEndIndex and @NextEndIndex >= @CurrentStartIndex
																		begin
																		
																			update ScratchDetectResult 
																			set level = 4 
																			where 
																				temp = @NextTemp
																				or
																				temp = @CurrentTemp;
																		
																		end
																
																end

															set @NextTemp = '';
															
															set @NextRightIndex += 1;
														
														end
														
													set @NextRightIndex = 1;
													
													set @EncoderIndex += 4;
												
												end
											
											set @EncoderIndex = 1;
											
											set @RightIndex += 1;
										
										end
								
								end
						
						END
					--单编码
					ELSE if @in_EncoderModel = 1
						BEGIN
						
							--检测左轮是否有擦伤
							if exists(select * from @CSLeftTable)
								begin
								
									--初始化编码器为左轮的循环因子
									set @EncoderIndex = 0;
									
									--循环当前轮子
									while @LeftIndex <= @CSLeftTotalCount
										begin
										
											--循环摆杆
											while @EncoderIndex <= 2
												begin
												
													--获取当前轮子指定摆杆的擦伤开始、结束位置
													select @CurrentStartIndex = X1,
														   @CurrrentEndIndex = X2,
														   @CurrentTemp = temp
													from   @CSLeftTable 
													where  [ID] = @LeftIndex 
													and 
													(
														   [swingNo] = @EncoderIndex 
														or 
														   [swingNo] = (@EncoderIndex + 1)
													);
													
													--循环剩余所有轮子
													while @NextLeftIndex <= @CSLeftTotalCount
														begin
														
															--获取下一轮子指定摆杆的擦伤开始、结束位置
															select @NextStartIndex = X1,
																   @NextEndIndex = X2,
																   @NextTemp = temp
															from   @CSLeftTable 
															where  [ID] = @NextLeftIndex 
															and 
															(
																   [swingNo] = @EncoderIndex 
																or 
																   [swingNo] = (@EncoderIndex + 1)
															);
															
															--下一轮子与当前轮子不是同一条数据
															if @NextTemp <> '' and @NextTemp <> @CurrentTemp
																begin
																
																	if @NextStartIndex <= @CurrrentEndIndex and @NextEndIndex >= @CurrentStartIndex
																		begin
																		
																			update ScratchDetectResult 
																			set level = 4 
																			where 
																				temp = @NextTemp
																				or
																				temp = @CurrentTemp;
																		
																		end
																
																end

															set @NextTemp = '';
															
															set @NextLeftIndex += 1;
														
														end
														
													set @NextLeftIndex = 1;
													
													set @EncoderIndex += 1;
												
												end
											
											set @EncoderIndex = 0;
											
											set @LeftIndex += 1;
										
										end
									
								end
								
							--重置变量
							set @CurrentStartIndex = 0;
							set @CurrrentEndIndex = 0;
							set @CurrentTemp = '';
							set @NextStartIndex = 0;
							set @NextEndIndex = 0;
							set @NextTemp = '';
							
							--检测右轮是否有擦伤
							if exists(select * from @CSRightTable)
								begin
								
									--初始化编码器为左轮的循环因子
									set @EncoderIndex = 0;
									
									--循环当前轮子
									while @RightIndex <= @CSRightTotalCount
										begin
										
											--循环摆杆
											while @EncoderIndex <= 2
												begin
												
													--获取当前轮子指定摆杆的擦伤开始、结束位置
													select @CurrentStartIndex = X1,
														   @CurrrentEndIndex = X2,
														   @CurrentTemp = temp
													from   @CSRightTable 
													where  [ID] = @RightIndex 
													and 
													(
														   [swingNo] = @EncoderIndex 
														or 
														   [swingNo] = (@EncoderIndex + 1)
													);
													
													--循环剩余所有轮子
													while @NextRightIndex <= @CSRightTotalCount
														begin
														
															--获取下一轮子指定摆杆的擦伤开始、结束位置
															select @NextStartIndex = X1,
																   @NextEndIndex = X2,
																   @NextTemp = temp
															from   @CSRightTable 
															where  [ID] = @NextRightIndex 
															and 
															(
																   [swingNo] = @EncoderIndex 
																or 
																   [swingNo] = (@EncoderIndex + 1)
															);
															
															--下一轮子与当前轮子不是同一条数据
															if @NextTemp <> '' and @NextTemp <> @CurrentTemp
																begin
																
																	if @NextStartIndex <= @CurrrentEndIndex and @NextEndIndex >= @CurrentStartIndex
																		begin
																		
																			update ScratchDetectResult 
																			set level = 4 
																			where 
																				temp = @NextTemp
																				or
																				temp = @CurrentTemp;
																		
																		end
																
																end

															set @NextTemp = '';
															
															set @NextRightIndex += 1;
														
														end
														
													set @NextRightIndex = 1;
													
													set @EncoderIndex += 1;
												
												end
											
											set @EncoderIndex = 0;
											
											set @RightIndex += 1;
										
										end
								
								end
						
						END
			end
	
	end try
	
	begin catch
	
		DECLARE @ErrorMessage NVARCHAR(4000);

        DECLARE @ErrorSeverity INT;

        DECLARE @ErrorState INT;

        SELECT  @ErrorMessage = ERROR_MESSAGE(),
                @ErrorSeverity = ERROR_SEVERITY(),
                @ErrorState = ERROR_STATE();
        RAISERROR (@ErrorMessage,1,@ErrorState) WITH LOG;

        RETURN;
	
	end catch

end
GO
/****** Object:  StoredProcedure [dbo].[FindBaseInfo]    Script Date: 06/16/2015 14:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**********************************************************************************************
-- 创建：董辉
-- 时间：2014-8-25 14:24
-- 说明：查询擦伤基本信息
**********************************************************************************************/
create proc [dbo].[FindBaseInfo]
(
	@in_testDateTime nvarchar(50),--时间
	
	@in_AxleNum int,--轴号
	
	@in_WheelNum int--轮号
)

as

begin 

	set NOCOUNT ON;
	
	--定义最终查询结果表变量
	declare @RecordTable table([CarTime]nvarchar(50),[CarAxle] int,[WhellPos] int,[CarID] nvarchar(50),[CarNum] int,[EngNum] nvarchar(50));
	
	--进线方向变量
	declare @Direction bit;
	
	--总共多少轴
	declare @AxleTotalCount int;
	
	--轴号
	declare @CarAxle int;
	
	--轮位
	declare @WhellPos int;
	
	--车厢ID
	declare @CarID nvarchar(50);
	
	--车厢序号
	DECLARE @CarNum int;
	
	--车厢位置
	declare @PosNo int;
	
	--车组号
	declare @engNum nvarchar(50);
	
	--获取进线方向（0反向进线，1正向进线）
	select @Direction = engineDirection,@AxleTotalCount = AxleNum from Detect 
	where 
	testDateTime = @in_testDateTime;
	
		--车组号
	SELECT @engNum = (case when engNum = 'unknown' then '未知' else engNum end) from Detect where testDateTime = @in_testDateTime;
	
	--轴号	
	select @CarAxle = dbo.axlePos(@engNum,@in_AxleNum,@Direction);
	
	--轮位
	select @WhellPos = dbo.wheelPos(@engNum,@in_AxleNum,@in_WheelNum,@Direction);
	
	--计算车厢位置
	set @PosNo = (@in_AxleNum * 2 + @in_WheelNum) / 8;
	
	--车厢ID
	select @CarID = carNo from CarList 
	where 
	testDateTime = @in_testDateTime 
	and 
	posNo = @PosNo;
	
	--车厢序号
	select @CarNum = dbo.carPos((@in_AxleNum / 4),(@AxleTotalCount / 4),@Direction);

	--结果存储表变量中
	insert into @RecordTable values(@in_testDateTime,@CarAxle,@WhellPos,@CarID,@CarNum,@engNum);

	--查询最终结果数据
	select * from @RecordTable;

end
GO
/****** Object:  StoredProcedure [dbo].[Profile_LjCha]    Script Date: 06/16/2015 14:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Profile_LjCha] 
@testTime datetime
--WITH ENCRYPTION
AS
declare @maxAxleNo int
declare @axleNo int
declare @zxjNo int
declare @carNo int
declare @cha float
declare @v float
declare @Lj float
declare @max float
declare @min float
declare @cursor_test cursor 
declare @bzh varchar(50)
--是否是5型车
declare @isCrh5 int

BEGIN
	SET NOCOUNT ON;
	select @bzh=engNum  
	from [tycho_kc].[dbo].detect 
	where testdatetime=@testTime	
	
	if (SUBSTRING(@bzh,1,4)!='CRH5') 
		begin
			set @isCrh5 = 0
		end
	else
		begin
			set @isCrh5 = 1
		end	
					
--同轴差
    select @maxAxleNo=max(axleNo) from ProfileDetectResult where testDateTime=@testTime
	set @axleNo = 0
	while (@axleNo <= @maxAxleNo)
		begin
			set @max = 0
			set @min = 1000
			set @cha = 0
			set @cursor_test = cursor for select lj from ProfileDetectResult where testDateTime=@testTime and axleNo = @axleNo
			open @cursor_test 
			fetch next from @cursor_test into @v
			while(@@fetch_status=0)
			begin
				if (@v!=-1000)
					 --set @cha = -1000
					 begin
				if (@v > @max)
					set @max = @v
				if (@v < @min)
					set @min = @v
					end
				fetch next from @cursor_test into @v
			end
			if (@cha != -1000)
				set @cha = @max - @min
			update ProfileDetectResult set LjCha_Zhou=@cha where testDateTime=@testTime and axleNo = @axleNo
			set @axleNo = @axleNo +1
		end 

--同架差
	set @zxjNo = 0
	while (@zxjNo <= @maxAxleNo/2)
		begin
			set @max = 0
			set @min = 1000
			set @cha = 0
			set @cursor_test = cursor for select lj from ProfileDetectResult where testDateTime=@testTime and axleNo/2 = @zxjNo
			open @cursor_test 
			fetch next from @cursor_test into @v
			while(@@fetch_status=0)
			begin
				if (@v!=-1000)
					--continue -- set @cha = -1000
					begin
				if (@v > @max)
					set @max = @v
				if (@v < @min)
					set @min = @v
					end
				fetch next from @cursor_test into @v
			end
			if (@cha != -1000)
				set @cha = @max - @min
			update ProfileDetectResult set LjCha_ZXJ=@cha where testDateTime=@testTime and axleNo/2 = @zxjNo
			set @zxjNo = @zxjNo +1
		end 

--同车差
	if (@isCrh5>0)
	--5型车只算动轴差
	begin
		set @carNo = 0
		while (@carNo <= @maxAxleNo/4)
			begin
				set @max = 0
				set @min = 1000
				set @cha = 0
				set @cursor_test = cursor for select lj,axleNo from ProfileDetectResult where testDateTime=@testTime and axleNo/4 = @carNo
				open @cursor_test 
				fetch next from @cursor_test into @v,@axleNo
				while(@@fetch_status=0)
				begin
				--5型车，1234轴中，23是动轴
					if (@v!=-1000) and ((@axleNo%4=1) or (@axleNo%4=2))
						--continue --set @cha = -1000
						begin
							if (@v > @max)
								set @max = @v
							if (@v < @min)
								set @min = @v
						end
					fetch next from @cursor_test into @v,@axleNo
				end
				if (@cha != -1000)
					set @cha = @max - @min
				update ProfileDetectResult set LjCha_Che=@cha where testDateTime=@testTime and axleNo/4 = @carNo
				set @carNo = @carNo +1
			end 	
	end
	
	else
	begin
	set @carNo = 0
	while (@carNo <= @maxAxleNo/4)
		begin
			set @max = 0
			set @min = 1000
			set @cha = 0
			set @cursor_test = cursor for select lj from ProfileDetectResult where testDateTime=@testTime and axleNo/4 = @carNo
			open @cursor_test 
			fetch next from @cursor_test into @v
			while(@@fetch_status=0)
			begin
				if (@v!=-1000)
					--continue --set @cha = -1000
					begin
				if (@v > @max)
					set @max = @v
				if (@v < @min)
					set @min = @v
					end
				fetch next from @cursor_test into @v
			end
			if (@cha != -1000)
				set @cha = @max - @min
			update ProfileDetectResult set LjCha_Che=@cha where testDateTime=@testTime and axleNo/4 = @carNo
			set @carNo = @carNo +1
		end 
	end	
--同车组差

			set @max = 0
			set @min = 1000
			set @cha = 0
			set @cursor_test = cursor for select lj from ProfileDetectResult where testDateTime=@testTime
			open @cursor_test 
			fetch next from @cursor_test into @v
			while(@@fetch_status=0)
			begin
				if (@v!=-1000)
					 --set @cha = -1000
					 begin
				if (@v > @max)
					set @max = @v
				if (@v < @min)
					set @min = @v
					end
				fetch next from @cursor_test into @v
			end

		if (@cha != -1000)
			set @cha = @max - @min
		update ProfileDetectResult set LjCha_Bz=@cha where testDateTime=@testTime		
	deallocate @cursor_test

END
GO
/****** Object:  StoredProcedure [dbo].[Profile]    Script Date: 06/16/2015 14:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: 20140624
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Profile] 
@testTime datetime
--WITH ENCRYPTION
AS
declare @up_level1 float
declare @up_level2 float
declare @up_level3 float
declare @low_level1 float
declare @low_level2 float
declare @low_level3 float
declare @max float
declare @min float
declare @axleNum int
declare @cursor_test cursor 
declare @level smallint
declare @v float
declare @axleNo int
declare @wheelNo int
declare @count int
declare @trainType varchar(20)
declare @carPos int
declare @dir int
--是否是5型车
declare @isCrh5 int
BEGIN
	SET NOCOUNT ON;
	set @level = 100;


	select @trainType = engNum, @dir= engineDirection from detect where testDateTime=@testTime
	if (CHARINDEX('-',@trainType) > 0)
		set @trainType= left(@trainType,CHARINDEX('-',@trainType)-1)
	else
		set @trainType= 'CRH2' --默认车型

	--set @trainType='default'; --客车没车型暂时用
	
	if (SUBSTRING(@trainType,1,4)!='CRH5') 
		begin
			set @isCrh5 = 0
		end
	else
		begin
			set @isCrh5 = 1
		end		

	--轮径
	select @up_level1=up_level1,@up_level2=up_level2,
           @up_level3=up_level3,@low_level1=low_level1,
           @low_level2=low_level2,@low_level3=low_level3 
    from thresholds where name='WX_LJ' and trainType=@trainType
    select @axleNum=AxleNum from detect where testDateTime=@testTime
	set @cursor_test = cursor for select axleNo,wheelNo,lj from ProfileDetectResult where testDateTime=@testTime
	open @cursor_test 
	fetch next from @cursor_test into @axleNo, @wheelNo,@v
	while(@@fetch_status=0)
	begin
		if (@v<0)
			set @level = null;
		else if (@v > @up_level1) or (@v < @low_level1)
			set @level = 1;
		else if  (@v > @up_level2) or (@v < @low_level2)
			set @level = 2;
		else if  (@v > @up_level3) or (@v < @low_level3)
			set @level = 3;
		else 
			set @level = 0;
		update ProfileDetectResult set Level_lj = @level where testDateTime=@testTime and axleNo=@axleNo and wheelNo=@wheelNo
		fetch next from @cursor_test into @axleNo, @wheelNo,@v
	end
	close @cursor_test
	select @level=min(Level_lj) from ProfileDetectResult where testDateTime=@testTime and axleNo<@axleNum and Level_lj>0
	if (@level is null)
		begin
			select @count = count(*) from ProfileDetectResult where testDateTime=@testTime and axleNo<@axleNum and Level_lj is null
			if (@count > 0)
				if (@count = @axleNum*2)
					set @level = null
				else
					set @level = 10
			else
				set @level = 0
		end
	update detect set M_Lj_Num = @level where testDateTime=@testTime
	--同轴轮径差
	select @up_level1=up_level1,@up_level2=up_level2,
           @up_level3=up_level3,@low_level1=low_level1,
           @low_level2=low_level2,@low_level3=low_level3 
    from thresholds where name='WX_LJC_Z' and trainType=@trainType
    select @axleNum=AxleNum from detect where testDateTime=@testTime
	set @cursor_test = cursor for select axleNo,wheelNo,LjCha_Zhou from ProfileDetectResult where testDateTime=@testTime
	open @cursor_test 
	fetch next from @cursor_test into @axleNo, @wheelNo,@v
	while(@@fetch_status=0)
	begin
		if (@v<0)
			set @level = null;
		else if (@v > @up_level1) or (@v < @low_level1)
			set @level = 1;
		else if  (@v > @up_level2) or (@v < @low_level2)
			set @level = 2;
		else if  (@v > @up_level3) or (@v < @low_level3)
			set @level = 3;
		else 
			set @level = 0;
		--print @level
		update ProfileDetectResult set Level_LjCha_Zhou = @level where testDateTime=@testTime and axleNo=@axleNo and wheelNo=@wheelNo
		fetch next from @cursor_test into @axleNo, @wheelNo,@v
	end
	close @cursor_test
	select @level=min(Level_LjCha_Zhou) from ProfileDetectResult where testDateTime=@testTime and axleNo<@axleNum and Level_LjCha_Zhou>0
	if (@level is null)
		begin
			select @count = count(*) from ProfileDetectResult where testDateTime=@testTime and axleNo<@axleNum and Level_LjCha_Zhou is null
			if (@count > 0)
				if (@count = @axleNum*2)
					set @level = null
				else
					set @level = 10
			else
				set @level = 0
		end
    select @v=M_Lj_Num from detect where testDateTime=@testTime
	if (@v = null)--没测
		update detect set M_Lj_Num = @level where testDateTime=@testTime
	
	else if (@v = 0)--正常
		begin
			if @level=null
				set @level = 10
			update detect set M_Lj_Num = @level where testDateTime=@testTime
		end
	else if (@v = 10)--正常但不全
		begin
			if (@level=null or @level=0 or @level=10)
				set @level = 10
			update detect set M_Lj_Num = @level where testDateTime=@testTime
		end
	else--有报警
		begin
			if (@level>0 and @level<@v)
				update detect set M_Lj_Num = @level where testDateTime=@testTime
		end
	--同架轮径差
	select @up_level1=up_level1,@up_level2=up_level2,
           @up_level3=up_level3,@low_level1=low_level1,
           @low_level2=low_level2,@low_level3=low_level3 
    from thresholds where name='WX_LJC_J' and trainType=@trainType
    select @axleNum=AxleNum from detect where testDateTime=@testTime
	set @cursor_test = cursor for select axleNo,wheelNo,LjCha_ZXJ from ProfileDetectResult where testDateTime=@testTime
	open @cursor_test 
	fetch next from @cursor_test into @axleNo, @wheelNo,@v
	while(@@fetch_status=0)
	begin
		if (@v<0)
			set @level = null;
		else if (@v > @up_level1) or (@v < @low_level1)
			set @level = 1;
		else if  (@v > @up_level2) or (@v < @low_level2)
			set @level = 2;
		else if  (@v > @up_level3) or (@v < @low_level3)
			set @level = 3;
		else 
			set @level = 0;
		update ProfileDetectResult set Level_LjCha_ZXJ = @level where testDateTime=@testTime and axleNo=@axleNo and wheelNo=@wheelNo
		fetch next from @cursor_test into @axleNo, @wheelNo,@v
	end
	close @cursor_test
	select @level=min(Level_LjCha_ZXJ) from ProfileDetectResult where testDateTime=@testTime and axleNo<@axleNum and Level_LjCha_ZXJ>0
	if (@level is null)
		begin
			select @count = count(*) from ProfileDetectResult where testDateTime=@testTime and axleNo<@axleNum and Level_LjCha_ZXJ is null
			if (@count > 0)
				if (@count = @axleNum*2)
					set @level = null
				else
					set @level = 10
			else
				set @level = 0
		end
    select @v=M_Lj_Num from detect where testDateTime=@testTime
	if (@v = null)--没测
		update detect set M_Lj_Num = @level where testDateTime=@testTime
	
	else if (@v = 0)--正常
		begin
			if @level=null
				set @level = 10
			update detect set M_Lj_Num = @level where testDateTime=@testTime
		end
	else if (@v = 10)--正常但不全
		begin
			if (@level=null or @level=0 or @level=10)
				set @level = 10
			update detect set M_Lj_Num = @level where testDateTime=@testTime
		end
	else--有报警
		begin
			if (@level>0 and @level<@v)
				update detect set M_Lj_Num = @level where testDateTime=@testTime
		end
	--同车轮径差
	select @up_level1=up_level1,@up_level2=up_level2,
           @up_level3=up_level3,@low_level1=low_level1,
           @low_level2=low_level2,@low_level3=low_level3 
    from thresholds where name='WX_LJC_C' and trainType=@trainType
    select @axleNum=AxleNum from detect where testDateTime=@testTime
	set @cursor_test = cursor for select axleNo,wheelNo,LjCha_Che from ProfileDetectResult where testDateTime=@testTime
	open @cursor_test 
	fetch next from @cursor_test into @axleNo, @wheelNo,@v

	while(@@fetch_status=0)
	begin
		if (@v<0)
			set @level = null;
		else if (@v > @up_level1) or (@v < @low_level1)
			set @level = 1;
		else if  (@v > @up_level2) or (@v < @low_level2)
			set @level = 2;
		else if  (@v > @up_level3) or (@v < @low_level3)
			set @level = 3;
		else 
			set @level = 0;
		--5型车只算动轴差，12478的23轴是动轴
		set @carPos = @axleNo/4
		if (@isCrh5 > 0) and (@dir=1) and (@carPos=2 or @carPos=4 or @carPos=5 or @carPos=10 or @carPos=12 or @carPos=13)
			set @level = 0
		if (@isCrh5 > 0) and (@dir=0) and (@carPos=2 or @carPos=3 or @carPos=5 or @carPos=10 or @carPos=11 or @carPos=13)
			set @level = 0
						
		update ProfileDetectResult set Level_LjCha_Che = @level where testDateTime=@testTime and axleNo=@axleNo and wheelNo=@wheelNo
		fetch next from @cursor_test into @axleNo, @wheelNo,@v
	end
	close @cursor_test
	select @level=min(Level_LjCha_Che) from ProfileDetectResult where testDateTime=@testTime and axleNo<@axleNum and Level_LjCha_Che>0
	if (@level is null)
		begin
			select @count = count(*) from ProfileDetectResult where testDateTime=@testTime and axleNo<@axleNum and Level_LjCha_Che is null
			if (@count > 0)
				if (@count = @axleNum*2)
					set @level = null
				else
					set @level = 10
			else
				set @level = 0
		end
    select @v=M_Lj_Num from detect where testDateTime=@testTime
	if (@v = null)--没测
		update detect set M_Lj_Num = @level where testDateTime=@testTime
	
	else if (@v = 0)--正常
		begin
			if @level=null
				set @level = 10
			update detect set M_Lj_Num = @level where testDateTime=@testTime
		end
	else if (@v = 10)--正常但不全
		begin
			if (@level=null or @level=0 or @level=10)
				set @level = 10
			update detect set M_Lj_Num = @level where testDateTime=@testTime
		end
	else--有报警
		begin
			if (@level>0 and @level<@v)
				update detect set M_Lj_Num = @level where testDateTime=@testTime
		end
		
	--同编组轮径差
	select @up_level1=up_level1,@up_level2=up_level2,
           @up_level3=up_level3,@low_level1=low_level1,
           @low_level2=low_level2,@low_level3=low_level3 
    from thresholds where name='WX_LJC_B' and trainType=@trainType
    select @axleNum=AxleNum from detect where testDateTime=@testTime
	set @cursor_test = cursor for select axleNo,wheelNo,LjCha_Bz from ProfileDetectResult where testDateTime=@testTime
	open @cursor_test 
	fetch next from @cursor_test into @axleNo, @wheelNo,@v
	while(@@fetch_status=0)
	begin
		if (@v<0)
			set @level = null;
		else if (@v > @up_level1) or (@v < @low_level1)
			set @level = 1;
		else if  (@v > @up_level2) or (@v < @low_level2)
			set @level = 2;
		else if  (@v > @up_level3) or (@v < @low_level3)
			set @level = 3;
		else 
			set @level = 0;
		update ProfileDetectResult set Level_LjCha_Bz = @level where testDateTime=@testTime
		break
	end
	close @cursor_test
    select @v=M_Lj_Num from detect where testDateTime=@testTime
	if (@v = null)--没测
		update detect set M_Lj_Num = @level where testDateTime=@testTime
	
	else if (@v = 0)--正常
		begin
			if @level=null
				set @level = 10
			update detect set M_Lj_Num = @level where testDateTime=@testTime
		end
	else if (@v = 10)--正常但不全
		begin
			if (@level=null or @level=0 or @level=10)
				set @level = 10
			update detect set M_Lj_Num = @level where testDateTime=@testTime
		end
	else--有报警
		begin
			if (@level>0 and @level<@v)
				update detect set M_Lj_Num = @level where testDateTime=@testTime
		end
		
		
	--踏面磨耗
	select @up_level1=up_level1,@up_level2=up_level2,
           @up_level3=up_level3,@low_level1=low_level1,
           @low_level2=low_level2,@low_level3=low_level3 
    from thresholds where name='WX_TMMH' and trainType=@trainType
	set @cursor_test = cursor for select axleNo,wheelNo,tmmh from ProfileDetectResult where testDateTime=@testTime
	open @cursor_test 
	fetch next from @cursor_test into @axleNo, @wheelNo,@v
	while(@@fetch_status=0)
	begin
		if (@v<-10)
			set @level = null;
		else if (@v > @up_level1) or (@v < @low_level1)
			set @level = 1;
		else if  (@v > @up_level2) or (@v < @low_level2)
			set @level = 2;
		else if  (@v > @up_level3) or (@v < @low_level3)
			set @level = 3;
		else 
			set @level = 0;
		update ProfileDetectResult set Level_tmmh = @level where testDateTime=@testTime and axleNo=@axleNo and wheelNo=@wheelNo
		fetch next from @cursor_test into @axleNo, @wheelNo,@v
	end
	close @cursor_test
	select @level=min(Level_tmmh) from ProfileDetectResult where testDateTime=@testTime and axleNo<@axleNum and Level_tmmh>0
	if (@level is null)
		begin
			select @count = count(*) from ProfileDetectResult where testDateTime=@testTime and axleNo<@axleNum and Level_tmmh is null
			if (@count > 0)
				if (@count = @axleNum*2)
					set @level = null
				else
					set @level = 10
			else
				set @level = 0
		end
	update detect set M_Tmmh_Num = @level where testDateTime=@testTime
	--轮缘厚度
	select @up_level1=up_level1,@up_level2=up_level2,
           @up_level3=up_level3,@low_level1=low_level1,
           @low_level2=low_level2,@low_level3=low_level3 
    from thresholds where name='WX_LYHD' and trainType=@trainType
	set @cursor_test = cursor for select axleNo,wheelNo,lyhd from ProfileDetectResult where testDateTime=@testTime
	open @cursor_test 
	fetch next from @cursor_test into @axleNo, @wheelNo,@v
	while(@@fetch_status=0)
	begin
		if (@v<0)
			set @level = null;
		else if (@v > @up_level1) or (@v < @low_level1)
			set @level = 1;
		else if  (@v > @up_level2) or (@v < @low_level2)
			set @level = 2;
		else if  (@v > @up_level3) or (@v < @low_level3)
			set @level = 3;
		else 
			set @level = 0;
		update ProfileDetectResult set Level_lyhd = @level where testDateTime=@testTime and axleNo=@axleNo and wheelNo=@wheelNo
		fetch next from @cursor_test into @axleNo, @wheelNo,@v
	end
	close @cursor_test
	select @level=min(Level_lyhd) from ProfileDetectResult where testDateTime=@testTime and axleNo<@axleNum and Level_lyhd>0
	if (@level is null)
		begin
			select @count = count(*) from ProfileDetectResult where testDateTime=@testTime and axleNo<@axleNum and Level_lyhd is null
			if (@count > 0)
				if (@count = @axleNum*2)
					set @level = null
				else
					set @level = 10
			else
				set @level = 0
		end	update detect set M_lyhd_Num = @level where testDateTime=@testTime
	--轮缘高度
	select @up_level1=up_level1,@up_level2=up_level2,
           @up_level3=up_level3,@low_level1=low_level1,
           @low_level2=low_level2,@low_level3=low_level3 
    from thresholds where name='WX_LYGD' and trainType=@trainType
	set @cursor_test = cursor for select axleNo,wheelNo,lygd from ProfileDetectResult where testDateTime=@testTime
	open @cursor_test 
	fetch next from @cursor_test into @axleNo, @wheelNo,@v
	while(@@fetch_status=0)
	begin
		if (@v<0)
			set @level = null;
		else if (@v > @up_level1) or (@v < @low_level1)
			set @level = 1;
		else if  (@v > @up_level2) or (@v < @low_level2)
			set @level = 2;
		else if  (@v > @up_level3) or (@v < @low_level3)
			set @level = 3;
		else 
			set @level = 0;
		update ProfileDetectResult set Level_lygd = @level where testDateTime=@testTime and axleNo=@axleNo and wheelNo=@wheelNo
		fetch next from @cursor_test into @axleNo, @wheelNo,@v
	end
	close @cursor_test
	select @level=min(Level_lygd) from ProfileDetectResult where testDateTime=@testTime and axleNo<@axleNum and Level_lygd>0
	if (@level is null)
		begin
			select @count = count(*) from ProfileDetectResult where testDateTime=@testTime and axleNo<@axleNum and Level_lygd is null
			if (@count > 0)
				if (@count = @axleNum*2)
					set @level = null
				else
					set @level = 10
			else
				set @level = 0
		end	
	update detect set M_lygd_Num = @level where testDateTime=@testTime
	--轮辋厚度
	select @up_level1=up_level1,@up_level2=up_level2,
           @up_level3=up_level3,@low_level1=low_level1,
           @low_level2=low_level2,@low_level3=low_level3 
    from thresholds where name='WX_LWHD' and trainType=@trainType
	set @cursor_test = cursor for select axleNo,wheelNo,lwhd from ProfileDetectResult where testDateTime=@testTime
	open @cursor_test 
	fetch next from @cursor_test into @axleNo, @wheelNo,@v
	while(@@fetch_status=0)
	begin
		if (@v<0)
			set @level = null;
		else if (@v > @up_level1) or (@v < @low_level1)
			set @level = 1;
		else if  (@v > @up_level2) or (@v < @low_level2)
			set @level = 2;
		else if  (@v > @up_level3) or (@v < @low_level3)
			set @level = 3;
		else 
			set @level = 0;
		update ProfileDetectResult set Level_lwhd = @level where testDateTime=@testTime and axleNo=@axleNo and wheelNo=@wheelNo
		fetch next from @cursor_test into @axleNo, @wheelNo,@v
	end
	close @cursor_test
	select @level=min(Level_lwhd) from ProfileDetectResult where testDateTime=@testTime and axleNo<@axleNum and Level_lwhd>0
	if (@level is null)
		begin
			select @count = count(*) from ProfileDetectResult where testDateTime=@testTime and axleNo<@axleNum and Level_lwhd is null
			if (@count > 0)
				if (@count = @axleNum*2)
					set @level = null
				else
					set @level = 10
			else
				set @level = 0
		end	
	update detect set M_lwhd_Num = @level where testDateTime=@testTime
	--QR
	select @up_level1=up_level1,@up_level2=up_level2,
           @up_level3=up_level3,@low_level1=low_level1,
           @low_level2=low_level2,@low_level3=low_level3 
    from thresholds where name='WX_QR' and trainType=@trainType
	set @cursor_test = cursor for select axleNo,wheelNo,qr from ProfileDetectResult where testDateTime=@testTime
	open @cursor_test 
	fetch next from @cursor_test into @axleNo, @wheelNo,@v
	while(@@fetch_status=0)
	begin
		if (@v<0)
			set @level = null;
		else if (@v > @up_level1) or (@v < @low_level1)
			set @level = 1;
		else if  (@v > @up_level2) or (@v < @low_level2)
			set @level = 2;
		else if  (@v > @up_level3) or (@v < @low_level3)
			set @level = 3;
		else 
			set @level = 0;
		update ProfileDetectResult set Level_qr = @level where testDateTime=@testTime and axleNo=@axleNo and wheelNo=@wheelNo
		fetch next from @cursor_test into @axleNo, @wheelNo,@v
	end
	close @cursor_test
	select @level=min(Level_qr) from ProfileDetectResult where testDateTime=@testTime and axleNo<@axleNum and Level_qr>0
	if (@level is null)
		begin
			select @count = count(*) from ProfileDetectResult where testDateTime=@testTime and axleNo<@axleNum and Level_qr is null
			if (@count > 0)
				if (@count = @axleNum*2)
					set @level = null
				else
					set @level = 10
			else
				set @level = 0
		end	
	update detect set M_qr_Num = @level where testDateTime=@testTime
	--内侧距
	select @up_level1=up_level1,@up_level2=up_level2,
           @up_level3=up_level3,@low_level1=low_level1,
           @low_level2=low_level2,@low_level3=low_level3 
    from thresholds where name='WX_NCJ' and trainType=@trainType
	set @cursor_test = cursor for select axleNo,wheelNo,ncj from ProfileDetectResult where testDateTime=@testTime
	open @cursor_test 
	fetch next from @cursor_test into @axleNo, @wheelNo,@v
	while(@@fetch_status=0)
	begin
		if (@v<0)
			set @level = null;
		else if (@v > @up_level1) or (@v < @low_level1)
			set @level = 1;
		else if  (@v > @up_level2) or (@v < @low_level2)
			set @level = 2;
		else if  (@v > @up_level3) or (@v < @low_level3)
			set @level = 3;
		else 
			set @level = 0;
		update ProfileDetectResult set Level_ncj = @level where testDateTime=@testTime and axleNo=@axleNo and wheelNo=@wheelNo
		fetch next from @cursor_test into @axleNo, @wheelNo,@v
	end
	close @cursor_test
	select @level=min(Level_ncj) from ProfileDetectResult where testDateTime=@testTime and axleNo<@axleNum and Level_ncj>0
	if (@level is null)
		begin
			select @count = count(*) from ProfileDetectResult where testDateTime=@testTime and axleNo<@axleNum and Level_ncj is null
			if (@count > 0)
				if (@count = @axleNum*2)
					set @level = null
				else
					set @level = 10
			else
				set @level = 0
		end
	update detect set M_ncj_Num = @level where testDateTime=@testTime

	deallocate @cursor_test

END
GO
/****** Object:  StoredProcedure [dbo].[VideoCS]    Script Date: 06/16/2015 14:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[VideoCS] 
@testTime datetime
--WITH ENCRYPTION
AS

declare @level smallint

BEGIN
	SET NOCOUNT ON;
    select @level=min(level) from VideoScratchDetectResult where testDateTime=@testTime and level>0
    update detect set videoScratchNum = @level where testDateTime=@testTime
END
GO
/****** Object:  View [dbo].[V_Detect_kc_outline]    Script Date: 06/16/2015 14:50:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[V_Detect_kc_outline]
AS
SELECT     TOP (12) testDateTime, AxleNum, isView, 
                      CASE WHEN isValid & 16 = 16 THEN '停车' WHEN isValid & 64 = 64 THEN '缺数' WHEN redwheelnum > 0 THEN '1' WHEN yellowwheelnum > 0 THEN '2' WHEN bluewheelnum
                       > 0 THEN '3' WHEN greenwheelnum > 0 THEN '正常' ELSE '正常' END AS s_level_ts, CASE isnull(scratchNum, - 1) 
                      WHEN - 1 THEN '-' WHEN 0 THEN '正常' ELSE str(scratchNum) END AS s_level_cs, CASE dbo.least(isnull(M_LJ_Num, 100), isnull(M_TmMh_Num, 100), 
                      isnull(M_LyHd_Num, 100), isnull(M_LyGd_Num, 100), isnull(M_LwHd_Num, 100), isnull(M_Qr_Num, 100), isnull(M_Ncj_Num, 100)) 
                      WHEN 100 THEN '-' WHEN 0 THEN '正常' WHEN 3 THEN '正常' WHEN 10 THEN '正常*' ELSE CAST(dbo.least(isnull(M_LJ_Num, 100), isnull(M_TmMh_Num, 100), 
                      isnull(M_LyHd_Num, 100), isnull(M_LyGd_Num, 100), isnull(M_LwHd_Num, 100), isnull(M_Qr_Num, 100), isnull(M_Ncj_Num, 100)) AS varchar(10)) END AS s_level_M, 
                      CASE dbo.Detect.engNum WHEN 'unknown' THEN '未录入...' ELSE dbo.Detect.engNum END AS bzh
FROM         dbo.Detect
WHERE     (AxleNum > 0) AND (engNum LIKE 'CRH%') AND (NOT EXISTS
                          (SELECT     testDateTime
                            FROM          dbo.ProcData
                            WHERE      (testDateTime = dbo.Detect.testDateTime) AND (NeedProc <> 0)))
ORDER BY testDateTime DESC
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[27] 4[8] 2[37] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Detect"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 114
               Right = 205
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 2085
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'V_Detect_kc_outline'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'V_Detect_kc_outline'
GO
/****** Object:  View [dbo].[V_Detect_kc]    Script Date: 06/16/2015 14:50:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[V_Detect_kc]
AS
SELECT     testDateTime, engNum, engBNum, engineDirection, bugNum, isView, inSpeed, outSpeed, waterTemp, temperature, liquidTemp, arrayATemp, arrayBTemp, isValid, 
                      wheelSize, wheelSizeB, IsTypical, AxleNum, 
                      CASE WHEN isValid & 16 = 16 THEN '停车' WHEN isValid & 64 = 64 THEN '缺数' WHEN redwheelnum > 0 THEN '1' WHEN yellowwheelnum > 0 THEN '2' WHEN bluewheelnum
                       > 0 THEN '3' WHEN greenwheelnum > 0 THEN '4' ELSE '正常' END AS s_level_ts, CASE isnull(scratchNum, - 1) 
                      WHEN - 1 THEN '-' WHEN 0 THEN '正常' ELSE str(scratchNum) END AS s_level_cs, CASE isnull(M_LJ_Num, - 1) 
                      WHEN - 1 THEN '-' WHEN 0 THEN '正常' WHEN 3 THEN '正常' WHEN 10 THEN '正常*' ELSE CAST(M_LJ_Num AS varchar(10)) END AS s_level_M_LJ, 
                      CASE isnull(M_TmMh_Num, - 1) WHEN - 1 THEN '-' WHEN 0 THEN '正常' WHEN 3 THEN '正常' WHEN 10 THEN '正常*' ELSE CAST(M_TmMh_Num AS varchar(10)) 
                      END AS s_level_M_TmMh, CASE isnull(M_LyHd_Num, - 1) 
                      WHEN - 1 THEN '-' WHEN 0 THEN '正常' WHEN 3 THEN '正常' WHEN 10 THEN '正常*' ELSE CAST(M_LyHd_Num AS varchar(10)) END AS s_level_M_LyHd, 
                      CASE isnull(M_LyGd_Num, - 1) WHEN - 1 THEN '-' WHEN 0 THEN '正常' WHEN 3 THEN '正常' WHEN 10 THEN '正常*' ELSE CAST(M_LyGd_Num AS varchar(10)) 
                      END AS s_level_M_LyGd, CASE isnull(M_LwHd_Num, - 1) 
                      WHEN - 1 THEN '-' WHEN 0 THEN '正常' WHEN 3 THEN '正常' WHEN 10 THEN '正常*' ELSE CAST(M_LwHd_Num AS varchar(10)) END AS s_level_M_LwHd, 
                      CASE isnull(M_Qr_Num, - 1) WHEN - 1 THEN '-' WHEN 0 THEN '正常' WHEN 3 THEN '正常' WHEN 10 THEN '正常*' ELSE CAST(M_Qr_Num AS varchar(10)) 
                      END AS s_level_M_Qr, CASE isnull(M_Ncj_Num, - 1) 
                      WHEN - 1 THEN '-' WHEN 0 THEN '正常' WHEN 3 THEN '正常' WHEN 10 THEN '正常*' ELSE CAST(M_Ncj_Num AS varchar(10)) END AS s_level_M_Ncj, 
                      CASE dbo.Detect.engNum WHEN 'unknown' THEN '未录入...' ELSE dbo.Detect.engNum END AS bzh
FROM         dbo.Detect
WHERE     (AxleNum > 0) AND (NOT EXISTS
                          (SELECT     testDateTime
                            FROM          dbo.ProcData
                            WHERE      (testDateTime = dbo.Detect.testDateTime) AND (NeedProc <> 0)))
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[19] 4[18] 2[38] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Detect"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 207
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 9
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 29
         Width = 284
         Width = 2010
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'V_Detect_kc'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'V_Detect_kc'
GO
/****** Object:  View [dbo].[V_Detect]    Script Date: 06/16/2015 14:50:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[V_Detect]
AS
SELECT     dbo.Detect.testDateTime,  REPLACE(CONVERT(varchar, dbo.Detect.testDateTime, 20), ':', '_') AS sDateTime, dbo.Detect.engNum, 
                      dbo.Detect.engineDirection, isnull(rest.resultNum, 0) as bugNum, isnull(rest.resultNumM, 0) as bugNum_M, 
					  case dbo.Detect.isValid when 0 then case isnull(rest.level, 0) when 0 then  '无' when 4 then  '无' when 5 then  '无' else str(rest.level,1) end else '无效' end as s_level,
					  case dbo.Detect.isValid when 0 then case isnull(rest.levelM, 0) when 0 then  '无' when 4 then  '无' when 5 then  '无' else str(rest.levelM,1) end else '无效' end as s_levelM,
					  case dbo.Detect.isValid when 0 then str(isnull(rest.resultNum, 0)) else '无效' end as s_bugNum,
					  case dbo.Detect.isValid when 0 then str(isnull(rest.resultNumM, 0)) else '无效' end as s_bugNum_M,
					  dbo.Detect.isView, dbo.Detect.inSpeed, dbo.Detect.outSpeed, dbo.Detect.waterTemp, dbo.Detect.IsTypical,
                      dbo.Detect.temperature, dbo.EngineLib.id, dbo.EngineLib.name, dbo.EngineLib.fullName, dbo.EngineLib.factoryId, dbo.EngineLib.typeId, 
                      dbo.Detect.wheelSize,
                      dbo.Engine.wheelSize as wheelSize_new, dbo.EngineLib.axleNum, dbo.EngineTypeLib.name AS typeName, dbo.FactoryLib.name AS factory, dbo.Engine.madeDate, 
                      dbo.Engine.engNumB, CASE engineDirection WHEN 'true' THEN '1←2' WHEN 'false' THEN '2←1' END AS s_engineDirection, 
					  dbo.Detect.isValid, right(dbo.Detect.engNum, 4) as sEngNum
FROM         dbo.Detect INNER JOIN
                      dbo.Engine ON dbo.Detect.engNum = dbo.Engine.engNum INNER JOIN
                      dbo.EngineLib ON dbo.Engine.Id = dbo.EngineLib.id INNER JOIN
                      dbo.FactoryLib ON dbo.EngineLib.factoryId = dbo.FactoryLib.id INNER JOIN
                      dbo.EngineTypeLib ON dbo.EngineLib.typeId = dbo.EngineTypeLib.id left JOIN
                      (select testdatetime,
min(level) as level, 
min(case when isbug=1 then level else 5 end) as levelM,
sum(case when level <4 then 1 else 0 end) as resultNum, 
sum(case when level <4 and isbug=1 then 1 else 0 end) as resultNumM 
from bugresult  group by testdatetime) rest ON dbo.Detect.testDateTime=rest.testDateTime
GO
/****** Object:  View [dbo].[V_BugResult]    Script Date: 06/16/2015 14:50:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[V_BugResult]
AS
SELECT     testDateTime, REPLACE(CONVERT(varchar, testDateTime, 20), ':', '_') AS sTestDateTime, axleNo, wheelNo, COUNT(*) AS BugNum, 
                      sum(CASE WHEN isbug = 1 THEN 1 ELSE 0 END) AS BugNum_M, min([LEVEL]) AS LEVEL, min(CASE WHEN isbug = 1 THEN LEVEL ELSE 5 END) AS levelM
FROM         dbo.BugResult
WHERE     LEVEL < 4
GROUP BY testDateTime, axleNo, wheelNo
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[18] 4[33] 2[22] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'V_BugResult'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'V_BugResult'
GO
/****** Object:  View [dbo].[V_Bug_Max]    Script Date: 06/16/2015 14:50:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create VIEW [dbo].[V_Bug_Max]
AS
SELECT     testDateTime, MAX(boGao) AS MaxBoGao
FROM         dbo.Bug
GROUP BY testDateTime
GO
/****** Object:  View [dbo].[V_Bug]    Script Date: 06/16/2015 14:50:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[V_Bug]
AS
SELECT     dbo.Bug.testDateTime, dbo.Bug.pos_angle, dbo.Bug.pos_deep, dbo.Bug.distance, dbo.Bug.axleNo, dbo.Bug.wheelNo, dbo.Bug.boGao, dbo.Bug.detectorType, 
                      dbo.Bug.detectorNo, dbo.Bug.level, dbo.DetectorTypeLib.name, CASE wheelNo WHEN 1 THEN '右' WHEN 0 THEN '左' END AS s_wheelNo
FROM         dbo.Bug INNER JOIN
                      dbo.DetectorTypeLib ON dbo.Bug.detectorType = dbo.DetectorTypeLib.id
GO
/****** Object:  StoredProcedure [dbo].[Locomotive_FindBaseInfo]    Script Date: 06/16/2015 14:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**********************************************************************************************
-- 创建：董辉
-- 时间：2014-8-25 14:24
-- 说明：查询擦伤基本信息
**********************************************************************************************/
create proc [dbo].[Locomotive_FindBaseInfo]
(
	@in_testDateTime nvarchar(50),	--时间
	
	@in_AxleNum int,				--轴号
	
	@in_WheelNum int,				--轮号
	
	@in_EncoderModel int			--运行模式
)

as

begin 

	set NOCOUNT ON;
	
	--定义最终查询结果表变量
	declare @RecordTable table([CarTime]nvarchar(50),[CarAxle] int,[WhellPos] int,[CarID] nvarchar(50),[CarNum] int,[EngNum] nvarchar(50));
	
	--定义最终查询结果表变量（机车专用）
	declare @RecordTable_JC table([CarTime]nvarchar(50),[CarAxle] int,[WhellPos_JC] nvarchar(100),[CarID] nvarchar(50),[EngNum] nvarchar(50));
	
	--进线方向变量
	declare @Direction bit;
	
	--总共多少轴
	declare @AxleTotalCount int;
	
	--轴号
	declare @CarAxle int;
	
	--轮位
	declare @WhellPos int;
	
	--轮位（机车专用）
	declare @WhellPos_JC nvarchar(100);
	
	--车厢ID
	declare @CarID nvarchar(50);
	
	--车厢序号
	DECLARE @CarNum int;
	
	--车厢位置
	declare @PosNo int;
	
	--车组号
	declare @engNum nvarchar(50);
	
	--获取进线方向（0反向进线，1正向进线）
	select @Direction = engineDirection,@AxleTotalCount = AxleNum from Detect 
	where 
	testDateTime = @in_testDateTime;
	
	--车组号
	SELECT @engNum = (case when engNum = 'unknown' then '未知' else engNum end) from Detect where testDateTime = @in_testDateTime;
	
	--机车专用
	if @in_EncoderModel = 2
		BEGIN
		
			--轴号	
			select @CarAxle = dbo.GetAxlePosByAxleNo(@in_testDateTime,@in_AxleNum);
		
		END
	else 
		BEGIN
		
			--轴号	
			select @CarAxle = dbo.axlePos(@engNum,@in_AxleNum,@Direction);
		
		END
	
	if @in_EncoderModel = 2
		BEGIN
		
				--轮位
				select @WhellPos_JC = dbo.GetWheelPosStr_By_TestDateTime_AxleNo_WheelNo(@in_testDateTime,@in_AxleNum,@in_WheelNum);
		
		END
	ELSE
		BEGIN
		
				--轮位
				select @WhellPos = dbo.wheelPos(@engNum,@in_AxleNum,@in_WheelNum,@Direction);
		
		END
	
	--计算车厢位置
	set @PosNo = (@in_AxleNum * 2 + @in_WheelNum) / 8;
	
	--车厢ID
	select @CarID = carNo from CarList 
	where 
	testDateTime = @in_testDateTime 
	and 
	posNo = @PosNo;
	
	if @in_EncoderModel = 2
		BEGIN
		
			--车厢序号
			select @CarNum = dbo.GetCarPosByAxleNo(@in_testDateTime,@in_AxleNum);
		
		END
	ELSE
		BEGIN
		
			--车厢序号
			select @CarNum = dbo.carPos((@in_AxleNum / 4),(@AxleTotalCount / 4),@Direction);
		
		END

	if @in_EncoderModel = 2
		BEGIN
		
			--结果存储表变量中
			insert into @RecordTable_JC values(@in_testDateTime,(@CarAxle + 1),@WhellPos_JC,@CarID,@engNum);
			
			--查询最终结果数据
			select * from @RecordTable_JC;
		
		END
	ELSE
		BEGIN
		
			--结果存储表变量中
			insert into @RecordTable values(@in_testDateTime,@CarAxle,@WhellPos,@CarID,@CarNum,@engNum);
			
			--查询最终结果数据
			select * from @RecordTable;
		
		END

end
GO
/****** Object:  StoredProcedure [dbo].[proc_JumpValuesChange]    Script Date: 06/16/2015 14:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**********************************************************************************************
-- 创建：董辉
-- 时间：2015-01-20 12:48
-- 说明：外形跳变数据调整（根据给出的正负绝对值范围确定是否需要调整，若需要则按上次日期的数据填充）
**********************************************************************************************/

CREATE proc [dbo].[proc_JumpValuesChange]
(
	@in_Flag nvarchar(5),					--标识（jc机车，dc动车）
	
	@in_testDateTime datetime,				--检测日期
	
	@in_NegativePercentage numeric(5,1),	--正基准值
	
	@in_PositivePercentage numeric(5,1),	--负基准值
	
	@out_Result int output					--操作结果（0失败）
)

as

begin

	set NOCOUNT ON;
	
	begin tran;
	
	begin TRY
	
		declare @ColumnI int = 1,			--字段表循环因子
				@ColumnCount int,			--字段表数据总行数
				@ColumnName nvarchar(100),	--字段名称
				@ExecSQL nvarchar(500),		--动态执行SQL变量
				@LjInnerColumnName nvarchar(100),--为轮径处理单独定义内部字段变量
				@LastExecSQL nvarchar(4000);--动态执行上次SQL变量
				
		--定义查询字段表变量
		declare @ColumnTable table([ID] int IDENTITY(1,1) not null,[ColumnName] nvarchar(50) not null);
		
		--定义报警数据临时表对象
		CREATE TABLE #WaringTable([ID] int identity(1,1) not null,[axleNo] int not null,[wheelNo] tinyint not null, [Value] numeric(5,1) null);
		
		--定义报警数据的上次数据临时表对象
		CREATE TABLE #LastWaringTable([ID] int identity(1,1) not null,[axleNo] int not null,[wheelNo] tinyint not null, [Value] numeric(5,1) null);
		
		--机车
		if @in_Flag = 'jc'
			BEGIN
			
				--插入需要处理的字段名
				insert into @ColumnTable values('Lj');   --轮径
				insert into @ColumnTable values('LyHd'); --轮缘厚度
				insert into @ColumnTable values('LyGd'); --轮缘高度
				insert into @ColumnTable values('LwHd'); --轮辋宽度
				insert into @ColumnTable values('Ncj');  --内侧距
			
			END
		--动车
		ELSE
			BEGIN
			
				insert into @ColumnTable values('Lj');   --轮径
				insert into @ColumnTable values('LyHd'); --轮缘厚度
				insert into @ColumnTable values('LyGd'); --轮缘高度
				insert into @ColumnTable values('LwHd'); --轮辋宽度
				insert into @ColumnTable values('QR');   --QR值
				insert into @ColumnTable values('Ncj');  --内侧距

			END
			
		--查询总行数
		select @ColumnCount = count(1) from @ColumnTable;
		
		--以字段表为准循环处理
		while @ColumnI <= @ColumnCount
			BEGIN
			
				--取相应行的字段名称
				select @ColumnName = [ColumnName] from @ColumnTable where [ID] = @ColumnI;
				
				--如果当前为轮径字段，则特殊处理。按范围从大到小，同轴差、轮径差。
				--每一个范围内如果有报警则查出此范围内的报警数据即可。
				if @ColumnName = 'Lj'
					BEGIN
						
						-- 一级范围-同轴差报警数据。如果没有则查找二级范围
						if not exists(select testDateTime from ProfileDetectResult where testDateTime = @in_testDateTime and Level_LjCha_Zhou > 0 and Level_LjCha_Zhou IS NOT NULL)
									BEGIN
											
										--二级范围-轮径报警数据。如果没有则不处理
										if not exists(select testDateTime from ProfileDetectResult where testDateTime = @in_testDateTime and Level_lj > 0 and Level_lj IS NOT NULL)
											BEGIN
													
												--当前待处理字段设置为空，不处理
												set @LjInnerColumnName = '';
													
											END
										--轮径有报警数据
										ELSE
											BEGIN
													
												--当前待处理字段设置为轮径
												set @LjInnerColumnName = 'Lj';
													
											END
									END
								--同轴差有报警数据
								ELSE
									BEGIN
											
										--当前待处理字段设置为同轴差
										set @LjInnerColumnName = 'LjCha_Zhou';
											
									END
							
						if @LjInnerColumnName <> ''
							BEGIN
							
								--拼合查询报警数据SQL
								set @ExecSQL =  N'insert into #WaringTable select axleNo,wheelNo,' + @ColumnName + ' from ProfileDetectResult ';
								set @ExecSQL += N'where testDateTime = '''+convert(nvarchar,@in_testDateTime,120)+''' and level_' + @LjInnerColumnName + ' > 0 order by axleNo asc,wheelNo asc';
							
								--动态执行查询报警数据SQL
								EXEC sp_executesql @ExecSQL;
								
							END
					
					END
				ELSE
					BEGIN
					
						--拼合查询报警数据SQL
						set @ExecSQL =  N'insert into #WaringTable select axleNo,wheelNo,' + @ColumnName + ' from ProfileDetectResult ';
						set @ExecSQL += N'where testDateTime = '''+convert(nvarchar,@in_testDateTime,120)+''' and level_' + @ColumnName + ' > 0 order by axleNo asc,wheelNo asc';
					
					END
				
				if @ColumnName <> 'Lj'
					BEGIN
					
						--动态执行查询报警数据SQL
						EXEC sp_executesql @ExecSQL;
					
					END
					
				--如果当前字段有报警的数据则处理
				if exists(select [ID] from #WaringTable)
					BEGIN
					
						if @ColumnName = 'Lj'
							BEGIN
							
								--查询当前日期轮径所有报警数据相对应的上一次数据集合
								set @LastExecSQL = N'
													insert into #LastWaringTable
													select  b.axleNo,
															b.wheelNo,
															(
																select top 1 c.'+@ColumnName+' 
																from 
																ProfileDetectResult_real c 
																where 
																c.carNo = b.carNo 
																and c.pos = b.pos 
																and c.testDateTime <> a.testDateTime 
																and c.testDateTime < a.testDateTime 
																order by c.testDateTime desc 
															) '+@ColumnName+'
													from ProfileDetectResult a 
													join 
														 ProfileDetectResult_real b
													on   a.testDateTime = b.testDateTime
													 and a.axleNo = b.axleNo
													 and a.wheelNo = b.wheelNo
													where a.testDateTime = '''+convert(nvarchar,@in_testDateTime,120)+'''
													 and a.Level_' + @LjInnerColumnName + ' > 0
													 and a.Level_' + @LjInnerColumnName + ' IS NOT NULL
													order by b.axleNo asc,b.wheelNo asc
												';
							
							END
						ELSE
							BEGIN
							
								--查询当前日期所有报警数据相对应的上一次数据集合
								set @LastExecSQL = N'
													insert into #LastWaringTable
													select  b.axleNo,
															b.wheelNo,
															(
																select top 1 c.'+@ColumnName+' 
																from 
																ProfileDetectResult_real c 
																where 
																c.carNo = b.carNo 
																and c.pos = b.pos 
																and c.testDateTime <> a.testDateTime 
																and c.testDateTime < a.testDateTime 
																order by c.testDateTime desc 
															) '+@ColumnName+'
													from ProfileDetectResult a 
													join 
														 ProfileDetectResult_real b
													on   a.testDateTime = b.testDateTime
													 and a.axleNo = b.axleNo
													 and a.wheelNo = b.wheelNo
													where a.testDateTime = '''+convert(nvarchar,@in_testDateTime,120)+'''
													 and a.Level_' + @ColumnName + ' > 0
													 and a.Level_' + @ColumnName + ' IS NOT NULL
													order by b.axleNo asc,b.wheelNo asc
												    ';
							
							END
								
						--动态执行查询上次数据并存入临时表				  
						exec(@LastExecSQL);
						
						--定义内层循环所需变量
						declare @innerI int = 1,			--内层循环因子
								@innerCount int,			--报警数据总行数
								@AxleNo int,				--当前轴号
								@WheelNo tinyint,			--当前轮号
								@CurrentValue NUMERIC(5,1), --报警数据
								@LastValue NUMERIC(5,1),	--报警数据对应的上一次数据
								@Percentage NUMERIC(5,1);   --结果值
							
						--查询报警数据总行数	
						select @innerCount = count(1) from #WaringTable;
						
						--循环处理报警数据，根据绝对值决定是否要调整数据
						while @innerI <= @innerCount
							BEGIN
							
								--取报警值与上一次的值
								select @CurrentValue = a.Value,
									   @LastValue = b.Value,
									   @AxleNo = a.axleNo,
									   @WheelNo = a.wheelNo
							    from #WaringTable a,#LastWaringTable b 
							    where a.ID = @innerI and b.ID = @innerI;
							    
							    --如果上次数据为-1000.0则为不正常数据
							    --本次就不处理
							    if @LastValue <> -1000.0
									BEGIN
									
										--计算报警值与上一次值的结果值
										select @Percentage = @CurrentValue - @LastValue;
									    
										--如果两数百分比在给定的比值范围内则不处理，如果超过范围则
										--以上次数据的值来更新本次的值
										if @Percentage < @in_PositivePercentage or @Percentage > @in_NegativePercentage
											BEGIN
											
												--更改数据SQL变量
												declare @InnerSQL nvarchar(500);
												
												--拼合数据SQL
												set @InnerSQL = N'update ProfileDetectResult set ' + @ColumnName + ' = ' + cast(@LastValue as varchar) + ' 
																  where testDateTime = '''+convert(nvarchar,@in_testDateTime,120)+''' and axleNo = ' + cast(@AxleNo as varchar) + 
																  ' and wheelNo = ' + cast(@WheelNo as varchar) + '';
												
												--动态执行更新数据SQL
												exec(@InnerSQL);
												
												--轮缘高度有变时踏面磨耗也重新计算
												if @ColumnName = 'LyGd'
													BEGIN
													
														--门限值变量
														declare @StandardValue NUMERIC(8,2);
														
														--查询本次日期对应的轮缘高度门限标准值
														select 
																DISTINCT @StandardValue = [standard] 
														from    thresholds 
														where   trainType = 
																(
																	 select 
																			DISTINCT dbo.TransformEngNum(engNum) 
																	 from   Detect 
																	 where  testDateTime = @in_testDateTime
																 )
														 and [name] = 'WX_LYGD';
														 
														 --更新踏面磨耗的值
														 update ProfileDetectResult 
														 set    TmMh = (@LastValue - @StandardValue) 
														 where  testDateTime = @in_testDateTime
														 and    axleNo = @AxleNo
														 and    wheelNo = @WheelNo;
													
													END
												
												--记录日志
												insert into ProfileChangeLjLog values(@in_testDateTime,@AxleNo,@WheelNo,@LastValue,3,@ColumnName);
											
											END
									
									END
								
								--累加内层循环因子
								set @innerI += 1;
							
							END
						
					END
				
				--清空上次临时对象中的数据，供下个字段使用
				TRUNCATE table #LastWaringTable;
				
				--清空临时对象中的数据，供下个字段使用
				TRUNCATE table #WaringTable;
				
				--累加循环因子
				set @ColumnI += 1;
			
			END
		
		--删除上次临时表对象	
		drop table #LastWaringTable
			
		--删除临时表对象
		drop table #WaringTable;
		
		--设置回传参数标志
		set @out_Result = 1;
		
		--提交事务
		commit tran;
	
	end TRY
	begin CATCH
	
		--设置回传参数标志
		set @out_Result = 0;
		
		--回滚事务并抛出异常给调用方程序
		rollback tran;

		DECLARE @ErrorMessage NVARCHAR(4000);

        DECLARE @ErrorSeverity INT;

        DECLARE @ErrorState INT;
		
		--返回错误信息
        SELECT  @ErrorMessage = ERROR_MESSAGE(),
                @ErrorSeverity = ERROR_SEVERITY(),
                @ErrorState = ERROR_STATE();
        RAISERROR (@ErrorMessage,1,@ErrorState) WITH LOG;

        RETURN;
	
	end CATCH

end
GO
/****** Object:  StoredProcedure [dbo].[proc_PrecisionAdjustment]    Script Date: 06/16/2015 14:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**********************************************************************************************
-- 创建：董辉
-- 时间：2015-02-05 14:39
-- 说明：外形精度数据调整
**********************************************************************************************/

create proc [dbo].[proc_PrecisionAdjustment]
(
	@in_testDateTime datetime,     --检测日期
	
	@out_Result		 int output	   --执行结果（0,1）
)

as

begin

	--不返回受影响行数
	set NOCOUNT ON;
	
	begin TRY
	
		--开启事务
		begin tran;
		
		--检测此日期是否有报警的数据
		if exists(select testDateTime from ProfileDetectResult 
				  where testDateTime = @in_testDateTime
				  AND
					(
						Level_lj > 0 or 
						Level_lyhd > 0 or 
						Level_lygd > 0 or 
						Level_lwhd > 0 or 
						Level_qr > 0 or 
						Level_ncj > 0
					)
				 )
			BEGIN
			
				--待检测字段表变量定义
				declare @ColumnTable table([ID] int IDENTITY(1,1) not null,[ColumnName] nvarchar(50) not null);
				
				--插入待检测字段
				insert into @ColumnTable values('Lj');   --轮径
				insert into @ColumnTable values('LyHd'); --轮缘厚度
				insert into @ColumnTable values('LyGd'); --轮缘高度
				insert into @ColumnTable values('LwHd'); --轮辋宽度
				insert into @ColumnTable values('QR');   --QR值
				insert into @ColumnTable values('Ncj');  --内侧距
				
				--定义临时数据存储表
				CREATE TABLE #WaringTable([ID] int identity(1,1) not null,[testDateTime] datetime not null,[axleNo] int not null,[wheelNo] tinyint not null, [Value] numeric(5,1) null);
				
				--定义检测字段表变量所需的变量
				declare @ColumnI	   int = 1,		   --循环因子
						@ColumnCount   int,			   --总行数
						@ColumnName    nvarchar(50),   --列名
						@EngNum		   nvarchar(50),   --车型	 
						@ColumnSQL     nvarchar(4000), --报警数据动态SQL
						@thresholdsSQL nvarchar(4000); --门限表数据动态SQL
						
				--定义门限临时数据存储表
				CREATE TABLE #thresholdsTable([ID] int identity(1,1) not null,[trainType] nvarchar(20),[name] nvarchar(10), [up_level1] numeric(8,2),[low_level1] numeric(8,2),[precision] numeric(8,2));
				
				--查询本次日期的车型
				select @EngNum = dbo.TransformEngNum(engNum) from Detect where testDateTime = @in_testDateTime;
				
				--根据车型查到相应的门限数据并存入临时表中，若车型为未知则按default查询
				if @EngNum = '未知'
					BEGIN
					
						insert into #thresholdsTable
						select [trainType],[name],[up_level1],[low_level1],[precision] from thresholds where trainType = 'default';
					
					END
				ELSE
					BEGIN
					
						insert into #thresholdsTable
						select [trainType],[name],[up_level1],[low_level1],[precision] from thresholds where trainType = @EngNum;
					
					END
			
						
				--查询待检测表总行数
				select @ColumnCount = count(1) from @ColumnTable;
				
				while @ColumnI <= @ColumnCount
					BEGIN
					
						--取指定行的列名
						select @ColumnName = [ColumnName] from @ColumnTable where [ID] = @ColumnI;	
						
						--指定列的报警数据插入临时存储表中
						set @ColumnSQL =  N'insert into #WaringTable select testDateTime,axleNo,wheelNo,' + @ColumnName + ' from ProfileDetectResult ';
						set @ColumnSQL += N'where testDateTime = '''+convert(nvarchar,@in_testDateTime,120)+''' and level_' + @ColumnName + ' > 0 order by axleNo asc,wheelNo asc';
						
						--动态执行SQL脚本
						EXEC sp_executesql @ColumnSQL;
						
						--如果临时数据存储表中有数据存在则此字段有报警数据，无则跳过并继续下个字段的检测
						if exists(select [ID] from #WaringTable)
							BEGIN
							
								--如果当前字段在门限表中有相应的门限值定义则处理，无则跳过并继续下个检测
								if exists(select count(1) from #thresholdsTable where name = ('WX_' + @ColumnName))
									BEGIN
									
										declare @up_level    numeric(8,2),   --门限上值
												@low_level   numeric(8,2),   --门限下值
												@precision   numeric(8,2),   --精度值
												@Current     numeric(5,1),   --待检测值
												@WaringI     int = 1,	     --报警数据循环因子
												@WaringCount int,		     --报警数据总行数
												@UpdateSQL   nvarchar(4000); --动态更新SQL
												
										--取相应的值到变量
										select @up_level = [up_level1],@low_level = [low_level1],@precision = [precision] from #thresholdsTable where name = ('WX_' + @ColumnName);
										
										--取报警数据总行数
										select @WaringCount = count(1) from #WaringTable;
										
										while @WaringI <= @WaringCount
											BEGIN
											
												--取相应行的数值
												select @Current = [Value] from #WaringTable where [ID] = @WaringI;
												
												--超过门限上值
												if @Current > @up_level
													BEGIN
													
														if @up_level > 0
															BEGIN
															
																--如果超过了精度值则更改此此行数据
																if @Current <= (@up_level + @precision) 
																	BEGIN
																	
																		set @UpdateSQL = N'update a set a.' + @ColumnName + ' = ' + cast(@up_level as varchar) + ' from ProfileDetectResult a join #WaringTable b 
																						   on a.testDateTime = b.testDateTime and a.axleNo = b.axleNo
																						   and a.wheelNo = b.wheelNo
																						   where b.ID = ' + cast(@WaringI as varchar) + ';';
																						   
																		--动态执行SQL脚本
																		EXEC sp_executesql @UpdateSQL;
																		
																	END
															
															END

													END
												--低于门限下值
												else if @Current < @low_level
													BEGIN
													
														if @low_level > 0
															BEGIN
															
																--如果超过了精度值则更改此此行数据
																if @Current >= (@low_level - @precision)
																	BEGIN
																	
																		set @UpdateSQL = N'update a set a.' + @ColumnName + ' = ' + cast(@low_level as varchar) + ' from ProfileDetectResult a join #WaringTable b 
																						   on a.testDateTime = b.testDateTime and a.axleNo = b.axleNo
																						   and a.wheelNo = b.wheelNo
																						   where b.ID = ' + cast(@WaringI as varchar) + ';';
																						   
																		--动态执行SQL脚本
																		EXEC sp_executesql @UpdateSQL;
																		
																	END
															
															END

													END
												
												--累加循环因子
												set @WaringI += 1;
											
											END
											
										--清空指定列内存储的报警数据
										TRUNCATE table #WaringTable;
									
									END
							
							END
							
						--累加循环因子
						set @ColumnI += 1;
					
					END
					
				-----------------------删除临时表----------------------
				drop table #WaringTable;
				
				drop table #thresholdsTable;
						
			END
			
		
		--设置回传参数为正常
		set @out_Result = 1;
		
		--提交事务
		COMMIT tran;
	
	end TRY
	begin CATCH
	
		--设置回传参数标志
		set @out_Result = 0;
		
		--回滚事务并抛出异常给调用方程序
		rollback tran;

		DECLARE @ErrorMessage NVARCHAR(4000);

        DECLARE @ErrorSeverity INT;

        DECLARE @ErrorState INT;
		
		--返回错误信息
        SELECT  @ErrorMessage = ERROR_MESSAGE(),
                @ErrorSeverity = ERROR_SEVERITY(),
                @ErrorState = ERROR_STATE();
        RAISERROR (@ErrorMessage,1,@ErrorState) WITH LOG;

        RETURN;
	
	end CATCH

end
GO
/****** Object:  StoredProcedure [dbo].[Locomotive_FilterCSByCoincidenceLocation]    Script Date: 06/16/2015 14:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**********************************************************************************************
-- 创建：董辉
-- 时间：2014-10-9 13:01
-- 说明：（机车专用,8摆杆）过滤多个轮子在同一摆杆位置有重合的伤数据
**********************************************************************************************/

create proc [dbo].[Locomotive_FilterCSByCoincidenceLocation]
(
	@in_TestDateTime datetime, --检测时间
	
	@in_EncoderModel int	   --编码模式（0：双编码，1：单编码）
)

as

begin

	--不返回受影响行数
	set nocount on;
	
	begin try
		
		--当前列车有伤时过滤
		if exists(select testDateTime from ScratchDetectResult where testDateTime = @in_TestDateTime)
			begin
			
					--定义变量
					declare @LeftIndex		   int = 1,		--左轮循环因子
							@NextLeftIndex	   int = 1,		--下一左轮循环因子
							@RightIndex		   int = 1,		--右轮循环因子
							@NextRightIndex	   int = 1,		--下一右轮循环因子
							@EncoderIndex	   int,			--确定编码器号循环因子
							@CSLeftTotalCount  int,			--左轮擦伤总行数
							@CSRightTotalCount int,		    --右轮擦伤总行数
							@CurrentTemp	   nvarchar(50),--当前轮子的GUID唯一号
							@NextTemp		   nvarchar(50),--下一轮子的GUID唯一号
						    @CurrentStartIndex int,			--定义当前轮子擦伤的开始位置
							@CurrrentEndIndex  int,			--定义当前轮子擦伤的结束位置
							@NextStartIndex	   int,			--定义下一轮子擦伤的开始位置
							@NextEndIndex	   int;			--定义下一轮子擦伤的结束位置
					
					--定义左轮表对象
					declare @CSLeftTable table(
												  [ID] int IDENTITY(1, 1) not null,
												  [temp] nvarchar(50) not null,
												  [X1] int not null,
												  [X2] int not null,
												  [swingNo] tinyint
											   );
											   
					--定义右轮表对象
					declare @CSRightTable table(
												  [ID] int IDENTITY(1, 1) not null,
												  [temp] nvarchar(50) not null,
												  [X1] int not null,
												  [X2] int not null,
												  [swingNo] tinyint
											   );
											   
					--插入左轮擦伤表数据
					insert into @CSLeftTable select [temp],[X1],[X2],[swingNo] from ScratchDetectResult 
											 where testDateTime = @in_TestDateTime and wheelNo = 0 
											 order by swingNo asc;
											 
					--插入右轮擦伤表数据
					insert into @CSRightTable select [temp],[X1],[X2],[swingNo] from ScratchDetectResult 
											 where testDateTime = @in_TestDateTime and wheelNo = 1
											 order by swingNo asc;
											 
					--获取左轮擦伤数据行数
					select @CSLeftTotalCount = COUNT(1) from @CSLeftTable;
					
					--获取右轮擦伤数据行数
					select @CSRightTotalCount = COUNT(1) from @CSRightTable;
					
					--双编码
					if @in_EncoderModel = 0
						BEGIN
						
							--检测左轮是否有擦伤
							if exists(select * from @CSLeftTable)
								begin
								
									--初始化编码器为左轮的循环因子
									set @EncoderIndex = 0;
									
									--循环当前轮子
									while @LeftIndex <= @CSLeftTotalCount
										begin
										
											--循环摆杆
											while @EncoderIndex <= 14
												begin
												
													--获取当前轮子指定摆杆的擦伤开始、结束位置
													select @CurrentStartIndex = X1,
														   @CurrrentEndIndex = X2,
														   @CurrentTemp = temp
													from   @CSLeftTable 
													where  [ID] = @LeftIndex 
													and 
													(
														   [swingNo] = @EncoderIndex 
														or 
														   [swingNo] = (@EncoderIndex + 2)
													);
													
													--循环剩余所有轮子
													while @NextLeftIndex <= @CSLeftTotalCount
														begin
														
															--获取下一轮子指定摆杆的擦伤开始、结束位置
															select @NextStartIndex = X1,
																   @NextEndIndex = X2,
																   @NextTemp = temp
															from   @CSLeftTable 
															where  [ID] = @NextLeftIndex 
															and 
															(
																   [swingNo] = @EncoderIndex 
																or 
																   [swingNo] = (@EncoderIndex + 2)
															);
															
															--下一轮子与当前轮子不是同一条数据
															if @NextTemp <> '' and @NextTemp <> @CurrentTemp
																begin
																
																	if @NextStartIndex <= @CurrrentEndIndex and @NextEndIndex >= @CurrentStartIndex
																		begin
																		
																			update ScratchDetectResult 
																			set level = 4 
																			where 
																				temp = @NextTemp
																				or
																				temp = @CurrentTemp;
																		
																		end
																
																end

															set @NextTemp = '';
															
															set @NextLeftIndex += 1;
														
														end
														
													set @NextLeftIndex = 1;
													
													set @EncoderIndex += 4;
												
												end
											
											set @EncoderIndex = 0;
											
											set @LeftIndex += 1;
										
										end
									
								end
								
							--重置变量
							set @CurrentStartIndex = 0;
							set @CurrrentEndIndex = 0;
							set @CurrentTemp = '';
							set @NextStartIndex = 0;
							set @NextEndIndex = 0;
							set @NextTemp = '';
							
							--检测右轮是否有擦伤
							if exists(select * from @CSRightTable)
								begin
								
									--初始化编码器为左轮的循环因子
									set @EncoderIndex = 1;
									
									--循环当前轮子
									while @RightIndex <= @CSRightTotalCount
										begin
										
											--循环摆杆
											while @EncoderIndex <= 15
												begin
												
													--获取当前轮子指定摆杆的擦伤开始、结束位置
													select @CurrentStartIndex = X1,
														   @CurrrentEndIndex = X2,
														   @CurrentTemp = temp
													from   @CSRightTable 
													where  [ID] = @RightIndex 
													and 
													(
														   [swingNo] = @EncoderIndex 
														or 
														   [swingNo] = (@EncoderIndex + 2)
													);
													
													--循环剩余所有轮子
													while @NextRightIndex <= @CSRightTotalCount
														begin
														
															--获取下一轮子指定摆杆的擦伤开始、结束位置
															select @NextStartIndex = X1,
																   @NextEndIndex = X2,
																   @NextTemp = temp
															from   @CSRightTable 
															where  [ID] = @NextRightIndex 
															and 
															(
																   [swingNo] = @EncoderIndex 
																or 
																   [swingNo] = (@EncoderIndex + 2)
															);
															
															--下一轮子与当前轮子不是同一条数据
															if @NextTemp <> '' and @NextTemp <> @CurrentTemp
																begin
																
																	if @NextStartIndex <= @CurrrentEndIndex and @NextEndIndex >= @CurrentStartIndex
																		begin
																		
																			update ScratchDetectResult 
																			set level = 4 
																			where 
																				temp = @NextTemp
																				or
																				temp = @CurrentTemp;
																		
																		end
																
																end

															set @NextTemp = '';
															
															set @NextRightIndex += 1;
														
														end
														
													set @NextRightIndex = 1;
													
													set @EncoderIndex += 4;
												
												end
											
											set @EncoderIndex = 1;
											
											set @RightIndex += 1;
										
										end
								
								end
						
						END
					--单编码
					ELSE if @in_EncoderModel = 1
						BEGIN
						
							--检测左轮是否有擦伤
							if exists(select * from @CSLeftTable)
								begin
								
									--初始化编码器为左轮的循环因子
									set @EncoderIndex = 0;
									
									--循环当前轮子
									while @LeftIndex <= @CSLeftTotalCount
										begin
										
											--循环摆杆
											while @EncoderIndex <= 2
												begin
												
													--获取当前轮子指定摆杆的擦伤开始、结束位置
													select @CurrentStartIndex = X1,
														   @CurrrentEndIndex = X2,
														   @CurrentTemp = temp
													from   @CSLeftTable 
													where  [ID] = @LeftIndex 
													and 
													(
														   [swingNo] = @EncoderIndex 
														or 
														   [swingNo] = (@EncoderIndex + 1)
													);
													
													--循环剩余所有轮子
													while @NextLeftIndex <= @CSLeftTotalCount
														begin
														
															--获取下一轮子指定摆杆的擦伤开始、结束位置
															select @NextStartIndex = X1,
																   @NextEndIndex = X2,
																   @NextTemp = temp
															from   @CSLeftTable 
															where  [ID] = @NextLeftIndex 
															and 
															(
																   [swingNo] = @EncoderIndex 
																or 
																   [swingNo] = (@EncoderIndex + 1)
															);
															
															--下一轮子与当前轮子不是同一条数据
															if @NextTemp <> '' and @NextTemp <> @CurrentTemp
																begin
																
																	if @NextStartIndex <= @CurrrentEndIndex and @NextEndIndex >= @CurrentStartIndex
																		begin
																		
																			update ScratchDetectResult 
																			set level = 4 
																			where 
																				temp = @NextTemp
																				or
																				temp = @CurrentTemp;
																		
																		end
																
																end

															set @NextTemp = '';
															
															set @NextLeftIndex += 1;
														
														end
														
													set @NextLeftIndex = 1;
													
													set @EncoderIndex += 1;
												
												end
											
											set @EncoderIndex = 0;
											
											set @LeftIndex += 1;
										
										end
									
								end
								
							--重置变量
							set @CurrentStartIndex = 0;
							set @CurrrentEndIndex = 0;
							set @CurrentTemp = '';
							set @NextStartIndex = 0;
							set @NextEndIndex = 0;
							set @NextTemp = '';
							
							--检测右轮是否有擦伤
							if exists(select * from @CSRightTable)
								begin
								
									--初始化编码器为左轮的循环因子
									set @EncoderIndex = 0;
									
									--循环当前轮子
									while @RightIndex <= @CSRightTotalCount
										begin
										
											--循环摆杆
											while @EncoderIndex <= 2
												begin
												
													--获取当前轮子指定摆杆的擦伤开始、结束位置
													select @CurrentStartIndex = X1,
														   @CurrrentEndIndex = X2,
														   @CurrentTemp = temp
													from   @CSRightTable 
													where  [ID] = @RightIndex 
													and 
													(
														   [swingNo] = @EncoderIndex 
														or 
														   [swingNo] = (@EncoderIndex + 1)
													);
													
													--循环剩余所有轮子
													while @NextRightIndex <= @CSRightTotalCount
														begin
														
															--获取下一轮子指定摆杆的擦伤开始、结束位置
															select @NextStartIndex = X1,
																   @NextEndIndex = X2,
																   @NextTemp = temp
															from   @CSRightTable 
															where  [ID] = @NextRightIndex 
															and 
															(
																   [swingNo] = @EncoderIndex 
																or 
																   [swingNo] = (@EncoderIndex + 1)
															);
															
															--下一轮子与当前轮子不是同一条数据
															if @NextTemp <> '' and @NextTemp <> @CurrentTemp
																begin
																
																	if @NextStartIndex <= @CurrrentEndIndex and @NextEndIndex >= @CurrentStartIndex
																		begin
																		
																			update ScratchDetectResult 
																			set level = 4 
																			where 
																				temp = @NextTemp
																				or
																				temp = @CurrentTemp;
																		
																		end
																
																end

															set @NextTemp = '';
															
															set @NextRightIndex += 1;
														
														end
														
													set @NextRightIndex = 1;
													
													set @EncoderIndex += 1;
												
												end
											
											set @EncoderIndex = 0;
											
											set @RightIndex += 1;
										
										end
								
								end
						
						END
			end
	
	end try
	
	begin catch
	
		DECLARE @ErrorMessage NVARCHAR(4000);

        DECLARE @ErrorSeverity INT;

        DECLARE @ErrorState INT;

        SELECT  @ErrorMessage = ERROR_MESSAGE(),
                @ErrorSeverity = ERROR_SEVERITY(),
                @ErrorState = ERROR_STATE();
        RAISERROR (@ErrorMessage,1,@ErrorState) WITH LOG;

        RETURN;
	
	end catch

end
GO
/****** Object:  UserDefinedFunction [dbo].[GetWheelSize]    Script Date: 06/16/2015 14:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[GetWheelSize]
(@testdatetime datetime ,@axleNo int,@wheelNo int, @default float)
RETURNS float
AS

BEGIN
declare @ret float
declare @carNo varchar(20)
declare @pos int

--优先取当前值
	select @ret=lj 
	from ProfileDetectResult 
	where testdatetime=@testdatetime and axleNo=@axleNo and wheelNo=@wheelNo and lj>0
	if (isnull(@ret, 0) <> 0)--有且是有效值
		return @ret
	
--取15天内最近值        
	select @carNo=carNo 
	from carlist 
	where testdatetime=@testdatetime and posNo=dbo.GetCarPosByAxleNo(@testdatetime,@axleNo)

	select @pos=dbo.GetWheelPos_By_TestDateTime_AxleNo_WheelNo(@testdatetime,@axleNo, @wheelNo)

	select top 1 @ret=lj_user 
	from ProfileDetectResult_real 
	where testdatetime<=@testdatetime and testdatetime>dateadd(day,-15,@testdatetime) 
	and carNo=@carNo and pos=@pos and lj_user>0 
	order by testdatetime desc
	if (isnull(@ret, 0) <> 0)
		return @ret

--取本次对面轮值
	select @ret=lj 
	from ProfileDetectResult 
	where testdatetime=@testdatetime and axleNo=@axleNo and wheelNo=1-@wheelNo and lj>0
	if isnull(@ret, 0)<> 0
	return @ret
	
--取本次，一个车厢的均值
	select @ret = avg(lj_user) 
	from ProfileDetectResult_real 
	where testdatetime=@testdatetime and carNo=@carNo and Lj_user>0
	if isnull(@ret, 0)<> 0
		return @ret
	
--取本次，整车均值
	select @ret = avg(lj_user) 
	from ProfileDetectResult_real 
	where testdatetime=@testdatetime and Lj_user>0
	if isnull(@ret, 0)<> 0
		return @ret

--取默认值
	return @default

END
GO
/****** Object:  StoredProcedure [dbo].[GetTrain]    Script Date: 06/16/2015 14:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Shenxd
-- Create date: 20140902
-- Description:	一次检测概况
-- =============================================
CREATE PROCEDURE [dbo].[GetTrain] 
@mDateTime char(20)
--WITH ENCRYPTION
AS

declare @AxleNum int
declare @dir int
--擦伤级别
declare @cs int
--视频擦伤级别
declare @vcs int
--擦伤级别文本
declare @Fcs varchar(20)
--视频擦伤级别文本
declare @Fvcs varchar(20)
declare @czh varchar(50)
declare @L0 varchar(20)
declare @L1 varchar(20)
declare @L2 varchar(20)
declare @L3 varchar(20)
declare @L4 varchar(20)
--升级三级不显示的时刻
declare @upgradeTime datetime
BEGIN

select @upgradeTime= dbo.GetUpgradeTime()

set @L0 = dbo.GetWord('无')
set @L1 = dbo.GetWord('I')
set @L2 = dbo.GetWord('II')
if (@mDateTime < @upgradeTime)
	set @L3 = 'III'
else
	set @L3 = dbo.GetWord('III')
set @L4 = dbo.GetWord('IIII')

select @czh=engnum,  @AxleNum = axleNum, @dir=engineDirection, @cs=isnull(scratchNum, - 1),  @vcs=isnull(videoScratchNum, - 1) from detect where testdatetime=@mDateTime
if (@cs = -1)
	set @Fcs = '-'
else
	set @Fcs = @L0
if (@vcs = -1)
	set @Fvcs = '-'
else
	set @Fvcs = @L0
SELECT   isnull(G.carNo,'') carNo,A.axleNo, A.wheelNo, A.axleNo/4 carIndex, 
dbo.carPos(A.axleNo/4, @AxleNum/4, @dir) carPos,dbo.axlePos(@czh,A.axleNo, @dir) axlePos, 
dbo.wheelPos(@czh, A.axleNo, A.wheelNo, @dir) Pos, 
B.level tslevelOrg,
c.cslevel cslevelOrg,
V.vcslevel vcsLevelOrg,
isnull(str(B.level),0) level,
case isnull(B.level,0) when 0 then @L0 when 1 then @L1  when 2 then @L2 when 3 then @L3 when 4 then @L4 end as sLevel_ts,
isnull(str(C.cslevel),0) cslevel,
case isnull(C.cslevel,0) when 0 then @Fcs when 1 then @L1  when 2 then @L2 when 3 then @L3 when 4 then @L4 end as sLevel_cs,
isnull(str(V.vcslevel),0) vcslevel,
case isnull(V.vcslevel,0) when 0 then @Fvcs when 1 then @L1  when 2 then @L2 when 3 then @L3 when 4 then @L4 end as sLevel_vcs,
isnull(C.deep,0) deep, isnull(str(D.Lj,5,1),'-') Lj,isnull(str(D.TmMh,5,1),'-') TmMh,isnull(str(D.LyHd,5,1),'-') LyHd,
isnull(str(D.LyGd,5,1),'-') LyGd,isnull(str(D.LwHd,5,1),'-') LwHd,isnull(str(D.Qr,5,1),'-') Qr,
isnull(str(D.Ncj,6,1),'-') Ncj,isnull(str(D.LjCha_Zhou,6,1),'-') LjCha_Zhou,isnull(str(D.LjCha_ZXJ,6,1),'-') LjCha_ZXJ, 
isnull(str(D.LjCha_Che,6,1),'-') LjCha_Che,isnull(str(D.LjCha_Bz,6,1),'-') LjCha_Bz,
isnull(D.Level_lj, 4) Level_lj,isnull(D.Level_LjCha_Bz, 4) Level_LjCha_Bz,isnull(D.Level_LjCha_Che, 4) Level_LjCha_Che,isnull(D.Level_LjCha_Zhou, 4) Level_LjCha_Zhou,isnull(D.Level_LjCha_ZXJ, 4) Level_LjCha_ZXJ,isnull(D.Level_lwhd, 4) Level_lwhd,isnull(D.Level_lygd, 4) Level_lygd,isnull(D.Level_lyhd, 4) Level_lyhd,isnull(D.Level_ncj, 4) Level_ncj,isnull(D.Level_qr, 4) Level_qr,isnull(D.Level_tmmh, 4) Level_tmmh,
E.status1, E.status2, E.status3, E.status4, F.status1 csStatus1, F.status2 csStatus2, F.status3 csStatus3 
FROM
                (select * from FullAxle_all where axleno< @AxleNum) A 
                 left join 
                (select axleno, wheelno, min(level) as level from bugresult where testdatetime=@mDateTime  and isbug=1 group by axleno, wheelno) B  
                on A.axleNo = B.axleNo AND A.wheelNo = B.wheelNo
                left join
                (select axleno, wheelno, min(level) as cslevel, max(scratch_depth) deep from scratchDetectResult where testDateTime = @mDateTime and isbug=1 group by axleno, wheelno) C
                on A.axleNo = C.axleNo AND A.wheelNo = C.wheelNo
                left join
                (select axleno, wheelno, min(level) as vcslevel  from VideoScratchDetectResult where testDateTime = @mDateTime group by axleno, wheelno) V
                on A.axleNo = V.axleNo AND A.wheelNo = V.wheelNo
                left join
                (select * from ProfileDetectResult where testDateTime = @mDateTime) D
                on A.axleNo = D.axleNo AND A.wheelNo = D.wheelNo 
                left join
                (select * from Sequ where testDateTime = @mDateTime) E
                on A.axleNo = E.axleNo AND A.wheelNo = E.wheelNo 
                left join
                (select * from CSSequ where testDateTime = @mDateTime) F
                on A.axleNo = F.axleNo
                left join
                (select carNo,posNo from carlist  where testDateTime = @mDateTime) G
                on A.axleNo/4 = G.posNo
                order by  axleNo,wheelNo desc

END
GO
/****** Object:  View [dbo].[TransformToCarData]    Script Date: 06/16/2015 14:50:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**********************************************************************************************
-- 创建：董辉
-- 时间：2014-9-16 9:35
-- 说明：创建视图，擦伤3级数据转换为对应的车厢号、轮位号数据。
**********************************************************************************************/

create view [dbo].[TransformToCarData]

as

SELECT     
	testDateTime, 
	dbo.GetCarNoByAxleNo(testDateTime, axleNo) carNo, 
	dbo.GetWheelPos_By_TestDateTime_AxleNo_WheelNo(testDateTime, axleNo, wheelNo) pos, 
	axleNo, 
	wheelNo, 
	min([LEVEL]) [LEVEL]
FROM         
	ScratchDetectResult
GROUP BY 
	testDateTime, 
	axleNo, 
	wheelNo;
GO
/****** Object:  StoredProcedure [dbo].[ReComputeAllProfile]    Script Date: 06/16/2015 14:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ReComputeAllProfile] 
--WITH ENCRYPTION
AS
declare @testTime datetime
declare @cursor_test cursor 
BEGIN
	SET NOCOUNT ON;
	set @cursor_test = cursor for select distinct(testdatetime) from ProfileDetectResult
	open @cursor_test 
	fetch next from @cursor_test into @testTime
	while(@@fetch_status=0)
	begin
		print @testTime
		exec Profile @testTime
		fetch next from @cursor_test into @testTime
	end
	close @cursor_test
	deallocate @cursor_test

END
GO
/****** Object:  StoredProcedure [dbo].[GetLastData2]    Script Date: 06/16/2015 14:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetLastData2] 
@testdatetime datetime,
@axleNo int,
@wheelNo int
--WITH ENCRYPTION
AS
declare @bzh varchar(50)
declare @carNo varchar(20)
declare @wheelPos int
declare @dir int
BEGIN
select @carNo=carNo from CarList where testDateTime=@testdatetime and posNo=@axleNo/4
select @bzh=engnum, @dir = engineDirection from Detect where testDateTime=@testdatetime
set @wheelPos = dbo.wheelpos(@bzh, @axleNo, @wheelNo, @dir)
exec GetLastData @carNo, @wheelPos

END
GO
/****** Object:  UserDefinedFunction [dbo].[GetWheelSizeSp]    Script Date: 06/16/2015 14:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[GetWheelSizeSp]
(@testdatetime datetime ,@axleNo int,@wheelNo int, @default float)
RETURNS float
AS

BEGIN
declare @ret float
declare @carNo varchar(20)
declare @preTime datetime
declare @dir int
declare @pos int
declare @bzh varchar(50)

select @dir=engineDirection, @bzh=engNum from detect where testdatetime=@testdatetime

set @ret= dbo.GetWheelSize(@testdatetime, @axleNo, @wheelNo, @default)
    

declare @trainType varchar(50)
declare @standardDm float

	if (CHARINDEX('-',@bzh) > 0)
		set @trainType= left(@bzh,CHARINDEX('-',@bzh)-1)
	else
		set @trainType= 'default' --默认车型

select @standardDm=standard from thresholds where trainType=@trainType and name='WX_LJ'  
if (@standardDm=null)
	select @standardDm=standard from thresholds where trainType='default' and name='WX_LJ'
set @ret = @standardDm - @ret
if (@ret <0)
	set @ret=0
    
RETURN @ret
END
GO
/****** Object:  StoredProcedure [dbo].[proc_TZC_DataAdjustment2]    Script Date: 06/16/2015 14:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**********************************************************************************************
-- 创建：shenxd
-- 时间：2015-05-13
-- 说明：外形同轴差数据调整2
**********************************************************************************************/

create proc [dbo].[proc_TZC_DataAdjustment2]
(
	@in_testDateTime datetime, --检测日期
	
	@out_Result int output	   --处理结果（0失败,1无须计算,2成功）
)

as 

begin 

	set NOCOUNT ON;
	
	begin TRAN;
	
	begin TRY
	
		--检测指定日期轮径差是否有报警，无则不需处理
		if exists(select testDateTime from ProfileDetectResult where Level_LjCha_Zhou > 0)
			BEGIN
				declare @LogSourceFlag int
				set @LogSourceFlag = 10
				
				--定义变量
				declare @Threshold     NUMERIC(8,2), --阀值
						@i		       int = 1,		 --循环因子
						@RowCount      int,			 --总行数
						@LJCha    	   NUMERIC(5,1), --轮径差值
						@AxleNo	       int,			 --轴号
						@WheelNo	   TINYINT,		 --轮号
						@Lj			   NUMERIC(5,1), --轮径值
						@testTimePre   datetime,	 --上次检测时间
						@pos		   int,			 --轮位
						@carPos        int,          --车厢序号
						@dir           int,          --方向
						@bzh           varchar(50),  --编组号
						@carNo         varchar(50);  --车厢号
						
				--车组号和方向
				select @bzh=engNum, @dir=engineDirection
				from Detect 
				where testDateTime=@in_testDateTime;
				
				--定义报警数据表对象
				declare @WarningData table([ID] int not null IDENTITY(1,1),[AxleNo] int not null,[WheelNo] TINYINT not null,[Lj] NUMERIC(5,1),[LjCha_Zhou] NUMERIC(5,1));
						
				--根据车号查找阀值
				if (select dbo.TransformEngNum(engNum) from Detect where testDateTime = @in_testDateTime) <> '未知'
					BEGIN
					
						select 
							 @Threshold = up_level1 
						from thresholds 
						where 
							 trainType = (select 
											dbo.TransformEngNum(engNum) 
										  from Detect 
										  where testDateTime = @in_testDateTime)
							 and name = 'WX_LJC_Z';
					
					END
				ELSE
					BEGIN
					
						select 
							 @Threshold = up_level1 
						from thresholds 
						where 
							 trainType = 'default'
							 and name = 'WX_LJC_Z';
					
					END
					
				--筛选出报警级别大于0的数据
				insert into @WarningData
				select 
						axleNo,
						wheelNo,
						Lj,
						LjCha_Zhou 
				from ProfileDetectResult 
				where testDateTime = @in_testDateTime 
				      and Level_LjCha_Zhou is not null 
				      and Level_LjCha_Zhou > 0
				order by axleNo, wheelNo;
					
				--获取报警数据的总行数	
				select @RowCount = count(1) from @WarningData;
				--清除已有日志
				delete from ProfileChangeLjLog
				where testDateTime = @in_testDateTime
				and ChangeColumn = 'Lj'
				and ChangeSource = @LogSourceFlag;

				
				--开始循环处理数据
				while @i <= @RowCount
					BEGIN
					
						--左轮径
					    declare @Lj_L NUMERIC(5,1);
					    
					    --右轮径
					    declare @Lj_R NUMERIC(5,1);
							    
					    --平均轮径
					    declare @Lj_AVG NUMERIC(5,1);
					    declare @AxleNo_L int;
					    declare @WheelNo_L int;
					    declare @AxleNo_R int;
					    declare @WheelNo_R int;

						--取第@i行的轮径差值
						select @LJ_L = [Lj], @AxleNo_L=AxleNo, @WheelNo_L=WheelNo from @WarningData where [ID] = @i;
						--取第@i + 1行的轮径差值
						select @LJ_R = [Lj], @AxleNo_R=AxleNo, @WheelNo_R=WheelNo  from @WarningData where [ID] = @i + 1;
						--如果出现不同轴，中止算法
						if (@AxleNo_L != @AxleNo_R)
							break;
						--找出车厢号和轮位	
						select @carPos =[dbo].[GetCarPosByAxleNo](@in_testDateTime, @AxleNo_L)
						set @pos = [tycho_kc].[dbo].wheelPos(@bzh,@AxleNo_L, @WheelNo_L, @dir)
						select @carNo=carNo from [tycho_kc].[dbo].CarList where testDateTime=@in_testDateTime and posNo=@carPos
						--上次检测时间
						select top 1 @testTimePre = testDateTime 
						from [tycho_kc].[dbo].[ProfileDetectResult_real] 
						where testDateTime < @in_testDateTime and carNo = @carNo and pos=@pos
						order by testDateTime desc
						
						--查日志，上次有没有经过此算法调整
						if not exists(select testdatetime from ProfileChangeLjLog where testDateTime=@testTimePre and AxleNo=@AxleNo_L and ChangeColumn='Lj' and ChangeSource=@LogSourceFlag)
							begin
								set @Lj_AVG = (@Lj_L + @Lj_R) / 2
								--调整左右轮径，使同轴差为1.0
								if (@Lj_L > @Lj_R)
									begin
										set @Lj_L = @Lj_AVG + @Threshold/2
										set @Lj_R = @Lj_AVG - @Threshold/2
									end
								else
									begin
										set @Lj_L = @Lj_AVG - @Threshold/2
										set @Lj_R = @Lj_AVG + @Threshold/2
									end
								
								--更改轮径
								update ProfileDetectResult
								set Lj = @Lj_L
								where testDateTime = @in_testDateTime
								and axleNo = @AxleNo_L
								and wheelNo = @WheelNo_L
								--记录日志
								insert into ProfileChangeLjLog
								values(@in_testDateTime, @AxleNo_L, @WheelNo_L, @Lj_L, @LogSourceFlag, 'Lj')
								
								--更改轮径
								update ProfileDetectResult
								set Lj = @Lj_R
								where testDateTime = @in_testDateTime
								and axleNo = @AxleNo_R
								and wheelNo = @WheelNo_R
								--记录日志						
								insert into ProfileChangeLjLog
								values(@in_testDateTime, @AxleNo_R, @WheelNo_R, @Lj_R, @LogSourceFlag, 'Lj')
						
							end
							
						--循环步进值为2
						set @i += 2;
					
					END
						
				--设置回传参数标志为成功
				set @out_Result = 2;
			
			END
		ELSE
			BEGIN
			
				--设置回传参数标志为无须计算
				set @out_Result = 1;
			
			END
		
		--提交事务
		commit tran;

		exec [tycho_kc].[dbo].profile_LjCha @in_testDateTime
		exec [tycho_kc].[dbo].profile @in_testDateTime	

	
	end TRY
	begin CATCH
	
		--回滚事务并抛出异常给调用方程序
		rollback tran;
		
		--设置回传参数标志为失败
		set @out_Result = 0;
		
		DECLARE @ErrorMessage NVARCHAR(4000);

        DECLARE @ErrorSeverity INT;

        DECLARE @ErrorState INT;
		
		--返回错误信息
        SELECT  @ErrorMessage = ERROR_MESSAGE(),
                @ErrorSeverity = ERROR_SEVERITY(),
                @ErrorState = ERROR_STATE();
        RAISERROR (@ErrorMessage,1,@ErrorState) WITH LOG;

        RETURN;
	
	end CATCH

end
GO
/****** Object:  StoredProcedure [dbo].[proc_TZC_DataAdjustment]    Script Date: 06/16/2015 14:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**********************************************************************************************
-- 创建：董辉
-- 时间：2015-01-07 11:53
-- 说明：外形同轴差数据调整
**********************************************************************************************/

create proc [dbo].[proc_TZC_DataAdjustment]
(
	@in_testDateTime datetime, --检测日期
	
	@out_Result int output	   --处理结果（0失败,1无须计算,2成功）
)

as 

begin 

	set NOCOUNT ON;
	
	begin TRAN;
	
	begin TRY
	
		--检测指定日期轮径差是否有报警，无则不需处理
		if exists(select testDateTime from ProfileDetectResult where Level_LjCha_Zhou > 0)
			BEGIN
				
				--定义变量
				declare @Threshold     NUMERIC(8,2), --阀值
						@i		       int = 1,		 --循环因子
						@RowCount      int,			 --总行数
						@LJCha    	   NUMERIC(5,1), --轮径差值
						@AxleNo	       int,			 --轴号
						@WheelNo	   TINYINT,		 --轮号
						@Lj			   NUMERIC(5,1); --轮径值
				
				--定义报警数据表对象
				declare @WarningData table([ID] int not null IDENTITY(1,1),[AxleNo] int not null,[WheelNo] TINYINT not null,[Lj] NUMERIC(5,1),[LjCha_Zhou] NUMERIC(5,1));
						
				--根据车号查找阀值
				if (select dbo.TransformEngNum(engNum) from Detect where testDateTime = @in_testDateTime) <> '未知'
					BEGIN
					
						select 
							 @Threshold = up_level1 
						from thresholds 
						where 
							 trainType = (select 
											dbo.TransformEngNum(engNum) 
										  from Detect 
										  where testDateTime = @in_testDateTime)
							 and name = 'WX_LJC_Z';
					
					END
				ELSE
					BEGIN
					
						select 
							 @Threshold = up_level1 
						from thresholds 
						where 
							 trainType = 'default'
							 and name = 'WX_LJC_Z';
					
					END
					
				--筛选出报警级别大于0的数据
				insert into @WarningData
				select 
						axleNo,
						wheelNo,
						Lj,
						LjCha_Zhou 
				from ProfileDetectResult 
				where testDateTime = @in_testDateTime 
				      and Level_LjCha_Zhou is not null 
				      and Level_LjCha_Zhou > 0;
					
				--获取报警数据的总行数	
				select @RowCount = count(1) from @WarningData;
				
				--开始循环处理数据
				while @i <= @RowCount
					BEGIN
					
						--大轮径数据ID
					    declare @BigLj int;
					    
					    --小轮径数据ID
					    declare @SmallLj int;
							    
						--取第@i行的轮径差值
						select @LJCha = [LjCha_Zhou] from @WarningData where [ID] = @i;
						
						--小于或等于1.6
						--大轮径： 轮径-(轮径差-门限/2) 重新计算轮径数据并更新
						--小轮径： 轮径+(轮径差-门限/2) 重新计算轮径数据并更新
						if @LJCha <= 1.6
							BEGIN
							
								--识别大、小轮径
								if (select [Lj] from @WarningData where [ID] = @i)
								  >(select [Lj] from @WarningData where [ID] = (@i + 1))
								    BEGIN
								   
										--前一条数据为大轮径的数据
										set @BigLj = @i;
										
										--后一条数据为小轮径的数据
										set @SmallLj = (@i + 1);
								   
								    END
								ELSE
									BEGIN
									
										--后一条数据为大轮径的数据
										set @BigLj = (@i + 1);
										
										--前一条数据为小轮径的数据
										set @SmallLj = @i;
									
									END
									
								--找出大轮径所需要数据
								select @Lj = [Lj],@AxleNo = [AxleNo],@WheelNo = [WheelNo] from @WarningData where [ID] = @BigLj;
								
								--重新计算大轮径的轮径值
								update ProfileDetectResult 
								set Lj = (@Lj - ((@LJCha - @Threshold) / 2))
								where testDateTime = @in_testDateTime
								and axleNo = @AxleNo
								and wheelNo = @WheelNo;
								
								--找出小轮径所需要数据
								select @Lj = [Lj],@AxleNo = [AxleNo],@WheelNo = [WheelNo] from @WarningData where [ID] = @SmallLj;
								
								--重新计算小轮径的轮径值
								update ProfileDetectResult 
								set Lj = (@Lj + ((@LJCha - @Threshold) / 2))
								where testDateTime = @in_testDateTime
								and axleNo = @AxleNo
								and wheelNo = @WheelNo;

							END
						--大于1.6
						--大轮径： 轮径-0.2 重新计算轮径数据并更新
						--小轮径： 轮径+0.2 重新计算轮径数据并更新
						ELSE
							BEGIN
							
							    --识别大、小轮径
								if (select [Lj] from @WarningData where [ID] = @i)
								  >(select [Lj] from @WarningData where [ID] = (@i + 1))
								    BEGIN
								   
										--前一条数据为大轮径的数据
										set @BigLj = @i;
										
										--后一条数据为小轮径的数据
										set @SmallLj = (@i + 1);
								   
								    END
								ELSE
									BEGIN
									
										--后一条数据为大轮径的数据
										set @BigLj = (@i + 1);
										
										--前一条数据为小轮径的数据
										set @SmallLj = @i;
									
									END
									
								--找出大轮径所需要数据
								select @Lj = [Lj],@AxleNo = [AxleNo],@WheelNo = [WheelNo] from @WarningData where [ID] = @BigLj;
								
								--重新计算大轮径的轮径值
								update ProfileDetectResult 
								set Lj = (@Lj - 0.2)
								where testDateTime = @in_testDateTime
								and axleNo = @AxleNo
								and wheelNo = @WheelNo;
								
								--找出小轮径所需要数据
								select @Lj = [Lj],@AxleNo = [AxleNo],@WheelNo = [WheelNo] from @WarningData where [ID] = @SmallLj;
								
								--重新计算小轮径的轮径值
								update ProfileDetectResult 
								set Lj = (@Lj + 0.2)
								where testDateTime = @in_testDateTime
								and axleNo = @AxleNo
								and wheelNo = @WheelNo;
							
							END
							
						--循环步进值为2
						set @i += 2;
					
					END
						
				--设置回传参数标志为成功
				set @out_Result = 2;
			
			END
		ELSE
			BEGIN
			
				--设置回传参数标志为无须计算
				set @out_Result = 1;
			
			END
		
		--提交事务
		commit tran;

		exec [tycho_kc].[dbo].profile_LjCha @in_testDateTime
		exec [tycho_kc].[dbo].profile @in_testDateTime	

	
	end TRY
	begin CATCH
	
		--回滚事务并抛出异常给调用方程序
		rollback tran;
		
		--设置回传参数标志为失败
		set @out_Result = 0;
		
		DECLARE @ErrorMessage NVARCHAR(4000);

        DECLARE @ErrorSeverity INT;

        DECLARE @ErrorState INT;
		
		--返回错误信息
        SELECT  @ErrorMessage = ERROR_MESSAGE(),
                @ErrorSeverity = ERROR_SEVERITY(),
                @ErrorState = ERROR_STATE();
        RAISERROR (@ErrorMessage,1,@ErrorState) WITH LOG;

        RETURN;
	
	end CATCH

end
GO
/****** Object:  StoredProcedure [dbo].[proc_BatchDatafillByLastTime]    Script Date: 06/16/2015 14:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**********************************************************************************************
-- 创建：董辉
-- 时间：2015-01-13 9:59
-- 说明：外形数据检测-本次日期若无数据则按上次日期为准，原样复制一份
**********************************************************************************************/

create proc [dbo].[proc_BatchDatafillByLastTime]
(
	@in_ThisTestDateTime datetime, --本次检测日期
	
	@in_LastTestDateTime datetime, --上次检测日期
	
	@out_Result int output	   --处理结果（ 0 出错，
										  --1 成功,
										  --2 ProfileDetectResult表无上次日期数据,
										  --3 ProfileDetectResult_real表无上次日期数据）
)

as

begin 

	set NOCOUNT ON;
	
	begin TRAN;
	
	begin TRY
	
		--检测ProfileDetectResult表本次日期，先删除再插入
		if exists(select testDateTime from ProfileDetectResult where testDateTime = @in_ThisTestDateTime)
			BEGIN
			
				delete ProfileDetectResult where testDateTime = @in_ThisTestDateTime;
			
			END
		
		--检测ProfileDetectResult_real表本次日期，先删除再插入
		if exists(select testDateTime from ProfileDetectResult_real where testDateTime = @in_ThisTestDateTime)
			BEGIN
			
				delete ProfileDetectResult_real where testDateTime = @in_ThisTestDateTime;
			
			END
			
		--检测ProfileDetectResult表上次日期数据是否存在
		if exists(select testDateTime from ProfileDetectResult where testDateTime = @in_LastTestDateTime)
			BEGIN
			
				--检测ProfileDetectResult表上次日期数据是否存在
				if exists(select testDateTime from ProfileDetectResult_real where testDateTime = @in_LastTestDateTime)
					BEGIN
					
						--复制ProfileDetectResult表上次日期数据到本次日期
						insert into ProfileDetectResult
						(
							[testDateTime],
							[axleNo],
							[wheelNo],
							[Lj], 
							[TmMh],
							[LyHd],
							[LyGd],
							[LwHd],
							[LwHd2],
							[QR],			
							[Ncj],			
							[LjCha_Zhou],		
							[LjCha_ZXJ],		
							[LjCha_Che],		
							[LjCha_Bz],			
							[xmlFile],		
							[Level_lj],			
							[Level_tmmh],		
							[Level_lyhd],		
							[Level_lwhd],		
							[Level_ncj],		
							[Level_lygd],		
							[Level_qr],        
							[Level_LjCha_Zhou],
							[Level_LjCha_ZXJ],	
							[Level_LjCha_Che],	
							[Level_LjCha_Bz]		
						)
						select 
							@in_ThisTestDateTime,
							[axleNo],
							[wheelNo],
							[Lj], 
							[TmMh],
							[LyHd],
							[LyGd],
							[LwHd],
							[LwHd2],
							[QR],			
							[Ncj],			
							[LjCha_Zhou],		
							[LjCha_ZXJ],		
							[LjCha_Che],		
							[LjCha_Bz],			
							[xmlFile],		
							[Level_lj],			
							[Level_tmmh],		
							[Level_lyhd],		
							[Level_lwhd],		
							[Level_ncj],		
							[Level_lygd],		
							[Level_qr],        
							[Level_LjCha_Zhou],
							[Level_LjCha_ZXJ],	
							[Level_LjCha_Che],	
							[Level_LjCha_Bz]	
						from ProfileDetectResult 
						where testDateTime = @in_LastTestDateTime;
						
						--复制ProfileDetectResult_real表上次日期数据到本次日期
						insert into ProfileDetectResult_real
						(
							[testDateTime],	
							[axleNo],		
							[wheelNo],		
							[Lj],			
							[TmMh],			
							[LyHd],			
							[LyGd],			
							[LwHd],			
							[LwHd2],			
							[QR],			
							[Ncj],			
							[LjCha_Zhou],	
							[LjCha_ZXJ],		
							[LjCha_Che],		
							[LjCha_Bz],		
							[xmlFile],		
							[pos],			
							[carPos],		
							[carNo],			
							[Lj_user],		
							[Lj_AVG],		
							[LwHd2_AVG]		
						)
						select 
							@in_ThisTestDateTime,	
							[axleNo],		
							[wheelNo],		
							[Lj],			
							[TmMh],			
							[LyHd],			
							[LyGd],			
							[LwHd],			
							[LwHd2],			
							[QR],			
							[Ncj],			
							[LjCha_Zhou],	
							[LjCha_ZXJ],		
							[LjCha_Che],		
							[LjCha_Bz],		
							[xmlFile],		
							[pos],			
							[carPos],		
							[carNo],			
							[Lj_user],		
							[Lj_AVG],		
							[LwHd2_AVG]	
						from ProfileDetectResult_real 
						where testDateTime = @in_LastTestDateTime;
						
						--设置回传参数标志
						set @out_Result = 1;
					
					END
				ELSE
					BEGIN
					
						--设置回传参数标志
						set @out_Result = 3;
					
					END
			
			END
		ELSE
			BEGIN
			
				--设置回传参数标志
				set @out_Result = 2;
			
			END
			
		--提交事务
		commit tran;
		
		--调用其它过程
		EXEC Profile @in_ThisTestDateTime;
		
	end TRY
	begin CATCH
	
	    --设置回传参数标志
		set @out_Result = 0;
		
		--回滚事务并抛出异常
		rollback tran;
		
		DECLARE @ErrorMessage NVARCHAR(4000);

        DECLARE @ErrorSeverity INT;

        DECLARE @ErrorState INT;

        SELECT  @ErrorMessage = ERROR_MESSAGE(),
                @ErrorSeverity = ERROR_SEVERITY(),
                @ErrorState = ERROR_STATE();
        RAISERROR (@ErrorMessage,1,@ErrorState) WITH LOG;

        RETURN;
	
	end CATCH

end
GO
/****** Object:  StoredProcedure [dbo].[Locomotive_FindDateScoapData]    Script Date: 06/16/2015 14:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**********************************************************************************************
-- 创建：董辉
-- 时间：2014-8-14 16:11
-- 说明：查询前30天历史记录信息（机车专用）
**********************************************************************************************/
create proc [dbo].[Locomotive_FindDateScoapData]
(
	@in_testDateTime datetime,
	
	@in_axle int,
	
	@in_wheel int,
	
	@in_EncoderModel int
)

as

begin

	set NOCOUNT ON;
	
	declare @carNo		nvarchar(20),
			@pos		int,
			@Direction  bit,
			@engNum		nvarchar(50),
			@AxleNum	int,
		    @dir		int,
		    @cs			int,
		    @Fcs		varchar(2),
		    @czh		varchar(20);
	
	--获取进线方向（0反向进线，1正向进线）
	--车组号
	select @Direction = engineDirection,
		   @engNum = (case when engNum = 'unknown' then '未知' else engNum end)
    from   Detect 
	where 
	      testDateTime = @in_testDateTime;

	if @in_EncoderModel = 2
		BEGIN
		
			--轮位
			select @pos = dbo.GetWheelPos_By_TestDateTime_AxleNo_WheelNo(@in_testDateTime,@in_axle,@in_wheel);
		
		END
	else 
		BEGIN
		
			--轮位
			select @pos = dbo.wheelPos(@engNum,@in_axle,@in_wheel,@Direction);
		
		END

	--车厢ID
	select @carNo = dbo.GetCarNoByAxleNo(@in_testDateTime,@in_axle);
	
	declare @t1 table(testdatetime datetime, carNo varchar(20));
	
	insert into @t1 select top 30 testDateTime, carNo from CarList where carNo=''+@carNo+'' order by testdatetime desc;

	declare @t2 table(testDateTime datetime, R_CarNo nvarchar(50),R_pos int,R_level int);
	
	insert into @t2 select top 30 testDateTime,R_CarNo,R_pos,R_level from ScratchDetectResult where R_CarNo=''+@carNo+'' and R_pos= cast(@pos as CHAR(2)) order by testDateTime desc;

	select  a.testdateTime,
			isnull(min(b.R_level),0) [level],
			a.carNo,
			@pos [pos],
			dbo.[GetAxleNo_By_TestDateTime_CarNo_WheelPos](a.testdateTime, a.carNo, @pos) axleNo,
			dbo.[GetWheelNoByPos](a.testdateTime,a.carNo, @pos) WheelNo
	from 
		    @t1 a
	left join
	        @t2 b
	on      a.testDateTime=b.testdatetime
	group by a.testdatetime,a.carNo
	order by a.testdateTime desc;

end
GO
/****** Object:  View [dbo].[V_TsBugResult]    Script Date: 06/16/2015 14:50:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[V_TsBugResult]
AS
SELECT     testdatetime, dbo.GetCarNoByAxleNo(testdatetime, axleNo) carNo, dbo.GetWheelPos_By_TestDateTime_AxleNo_WheelNo(testDateTime, axleNo, wheelNo) pos, 
                      axleNo, wheelNo, min(LEVEL) LEVEL
FROM         BugResult
GROUP BY testDateTime, axleNo, wheelNo
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'V_TsBugResult'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'V_TsBugResult'
GO
/****** Object:  View [dbo].[V_NeedView]    Script Date: 06/16/2015 14:50:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[V_NeedView]
AS
SELECT     dbo.V_Bug_Max.testDateTime, dbo.V_Bug_Max.MaxBoGao, REPLACE(CONVERT(varchar, dbo.Detect.testDateTime, 20), ':', '_') AS sDateTime
FROM         dbo.V_Bug_Max INNER JOIN
                      dbo.Detect ON dbo.V_Bug_Max.testDateTime = dbo.Detect.testDateTime
WHERE     (dbo.Detect.isView = 'false')
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Detect"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 125
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'V_NeedView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'V_NeedView'
GO
/****** Object:  StoredProcedure [dbo].[Profile_patch2]    Script Date: 06/16/2015 14:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	由轮辋厚度，估算轮径
-- =============================================
CREATE PROCEDURE [dbo].[Profile_patch2] 
@testTime datetime
--WITH ENCRYPTION
AS
declare @Count int
declare @cursor_test cursor
declare @cursor_1 cursor 
declare @axleNo int
declare @wheelNo int
declare @id int
declare @v float
declare @lj_now float
declare @lwhd2 float
declare @dir int
declare @AxleNum int
declare @pos int
declare @carPos int
declare @carNo varchar(20)
declare @t1 datetime
declare @a1 int
declare @w1 int
declare @v_left float
declare @v_right float
declare @b_left float
declare @b_right float
declare @lwhd_left float
declare @lwhd_right float
declare @pos_left float
declare @pos_right float
declare @haveUpdate int
declare @Lj_AVG float
declare @bzh varchar(20)
BEGIN
	SET NOCOUNT ON;
	set @haveUpdate = 0
    select @Count=count(*) from ProfileDetectResult where testDateTime=@testTime and Level_LjCha_Zhou>0
	if (@Count > 0)
		begin
			delete from [tycho_kc].[dbo].[ProfilePatchLog2] where testDateTime=@testTime
		    select @bzh=engNum, @AxleNum = axleNum, @dir=engineDirection  from [tycho_kc].[dbo].detect where testdatetime=@testTime
			set @cursor_test = cursor for select axleNo,wheelNo,lj,lwhd2 from ProfileDetectResult where testDateTime=@testTime and Level_LjCha_Zhou>0 order by axleNo,wheelNo
			open @cursor_test 
			fetch next from @cursor_test into @axleNo, @wheelNo,@lj_now,@lwhd2
			while(@@fetch_status=0)
			begin
				--print 'axle:'+cast(@axleNo as varchar(10))+ '  wheel:' + cast(@wheelNo as varchar(10)) + '  diameter:'+ cast(@lj_now as varchar(10))
				set @carPos = @axleNo/4
				--print @carPos

				set @pos = [tycho_kc].[dbo].wheelPos(@bzh, @axleNo, @wheelNo, @dir)
				select @carNo=carNo from [tycho_kc].[dbo].CarList where testDateTime=@testTime and posNo=@carPos
				--print @carNo
				--print @pos
				if (@wheelNo = 0)
					begin
						set @v_left = @lj_now
						set @b_left = ABS(@lwhd2*2+745-@lj_now)
						set @lwhd_left = @lwhd2
					end
				else
					begin
						set @v_right = @lj_now
						set @b_right = ABS(@lwhd2*2+745-@lj_now)
						set @lwhd_right = @lwhd2
						if (@b_left >@b_right)--右比较准
							begin
								set @v = @v_right+(@lwhd_left-@lwhd_right)*2
								update ProfileDetectResult set Lj=@v where testDateTime=@testTime and axleNo=@axleNo and wheelNo=0
								--update ProfileDetectResult_real set Lj_user=@v_left where testDateTime=@testTime and axleNo=@axleNo and wheelNo=0
								insert into ProfilePatchLog2 values(@testTime,@axleNo,0,@carNo,@pos_left,@v_left, @v)
							end
						else if (@b_left < @b_right)
							begin
								set @v = @v_left+(@lwhd_right - @lwhd_left)*2
								update ProfileDetectResult set Lj= @v where testDateTime=@testTime and axleNo=@axleNo and wheelNo=1
								--update ProfileDetectResult_real set Lj_user=@v_right where testDateTime=@testTime and axleNo=@axleNo and wheelNo=1
								insert into ProfilePatchLog2 values(@testTime,@axleNo,1,@carNo,@pos_right,@v_right, @v)
						    end
						set @haveUpdate = 1
					end
				fetch next from @cursor_test into @axleNo, @wheelNo,@lj_now,@lwhd2
			end
			close @cursor_test
			--需要重算
			if (@haveUpdate >0)
				begin
					exec [tycho_kc].[dbo].profile_LjCha @testTime
					exec [tycho_kc].[dbo].profile @testTime
			    end
			    
--恢复			    
    select @Count=count(*) from ProfileDetectResult where testDateTime=@testTime and Level_LjCha_Zhou>0
	if (@Count > 0)
		begin
			set @cursor_test = cursor for select axleNo,wheelNo from ProfileDetectResult where testDateTime=@testTime and Level_LjCha_Zhou>0 order by axleNo,wheelNo
			open @cursor_test 
			fetch next from @cursor_test into @axleNo, @wheelNo
			while(@@fetch_status=0)
			begin
				select @Lj_AVG=Lj_avg from ProfileDetectResult_real where testDateTime=@testTime and axleNo=@axleNo and wheelNo=@wheelNo
				if (ISNULL(@Lj_AVG, 0) = 0)
					select @Lj_AVG=Lj from ProfileDetectResult_real where testDateTime=@testTime and axleNo=@axleNo and wheelNo=@wheelNo
				update ProfileDetectResult set Lj= @Lj_AVG where testDateTime=@testTime and axleNo=@axleNo and wheelNo=@wheelNo
				fetch next from @cursor_test into @axleNo, @wheelNo
			end
			close @cursor_test
			exec [tycho_kc].[dbo].profile_LjCha @testTime
			exec [tycho_kc].[dbo].profile @testTime
			
		end			    
			    
		end
END
GO
/****** Object:  StoredProcedure [dbo].[Profile_patch0]    Script Date: 06/16/2015 14:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	均值处理
-- =============================================
CREATE PROCEDURE [dbo].[Profile_patch0] 
@testTime datetime
--WITH ENCRYPTION
AS
declare @CountNeed int
declare @cursor_test cursor
declare @cursor_1 cursor 
declare @axleNo int
declare @wheelNo int
declare @id int
declare @v float
declare @lj_now float
declare @dir int
declare @AxleNum int
declare @pos int
declare @carPos int
declare @carNo varchar(20)
declare @t1 datetime
declare @a1 int
declare @w1 int
declare @v_left float
declare @v_right float
declare @b_left float
declare @b_right float
declare @org_left float
declare @org_right float
declare @pos_left float
declare @pos_right float
declare @haveUpdate int
declare @Lj_SUM float
declare @Lj_AVG float
declare @Lj_MAX float
declare @Lj_MIN float
declare @LwHd2_SUM float
declare @LwHd2_AVG float
declare @LwHd2_MAX float
declare @LwHd2_MIN float
declare @Count int
declare @days int
declare @NoData int
declare @diameter float
declare @rim_thickness2 float
declare @bzh varchar(20)
BEGIN
	SET NOCOUNT ON;
	set @haveUpdate = 0
	set @days = 15
	set @NoData=-1000
    select @CountNeed=count(*) from ProfileDetectResult where testDateTime=@testTime and Level_LjCha_Zhou>0
	if (@CountNeed > 0)
		begin
			delete from [tycho_kc].[dbo].[ProfilePatchLog0] where testdatetime=@testTime
		    select @bzh=engNum, @AxleNum = axleNum, @dir=engineDirection  from [tycho_kc].[dbo].detect where testdatetime=@testTime
			set @cursor_test = cursor for select axleNo,wheelNo,lj,lwhd2 from ProfileDetectResult where testDateTime=@testTime and Level_LjCha_Zhou>0 order by axleNo,wheelNo
			open @cursor_test 
			fetch next from @cursor_test into @axleNo, @wheelNo,@diameter,@rim_thickness2
			while(@@fetch_status=0)
			begin
				--有可能轮经或轮网厚只有一个没有测出，所以分别算
				set @carPos = @axleNo/4
				set @pos = dbo.wheelPos(@bzh, @axleNo, @wheelNo, @dir)
				select @carNo=carNo from [tycho_kc].[dbo].CarList where testDateTime=@testTime and posNo=@carPos
			
				if (@diameter = @NoData)
					set @Lj_AVG= @NoData
				else
				begin
					SELECT @Lj_SUM=SUM(lj),@Lj_MAX=MAX(lj),@Lj_MIN=MIN(lj),@Count=COUNT(lj)
					FROM [tycho_kc].[dbo].[ProfileDetectResult_real]
					--where carNo=@carNo and axleNo=@axleNo and wheelNo=@wheelNo and testDateTime>dateadd(DAY,-@days,@testTime) and testDateTime<=@testTime and lj!=-1000
					where carNo=@carNo and pos=@pos and testDateTime>dateadd(DAY,-@days,@testTime) and testDateTime<=@testTime and lj!=-1000
			
					if (@Count<=2)--至少有当前一条，所以不会为0
						begin
							set @Lj_AVG = @Lj_SUM / @Count
						end
					else
						begin
							set @Lj_AVG = (@Lj_SUM-@Lj_MAX-@Lj_MIN) / (@Count-2)
						end
				end	
				if (@rim_thickness2=@NoData)
					set @LwHd2_AVG = @NoData
				else
				begin
					SELECT @LwHd2_SUM=SUM(LwHd2),@LwHd2_MAX=MAX(LwHd2),@LwHd2_MIN=MIN(LwHd2),@Count=COUNT(LwHd2)
					FROM [tycho_kc].[dbo].[ProfileDetectResult_real]
					--where carNo=@carNo and axleNo=@axleNo and wheelNo=@wheelNo and testDateTime>dateadd(DAY,-@days,@testTime) and LwHd2!=-1000
					where carNo=@carNo and pos=@pos and testDateTime>dateadd(DAY,-@days,@testTime) and LwHd2!=-1000
					if (@Count<=2)
						begin
							set @LwHd2_AVG = @LwHd2_SUM /@Count
						end
					else
						begin
							set @LwHd2_AVG = (@LwHd2_SUM-@LwHd2_MAX-@LwHd2_MIN) /(@Count-2)
						end
				end
				update [tycho_kc].[dbo].[ProfileDetectResult_real] set Lj_AVG=@Lj_AVG, LwHd2_AVG=@LwHd2_AVG where testDateTime=@testTime and axleNo=@axleNo and wheelNo=@wheelNo
				update  [tycho_kc].[dbo].[ProfileDetectResult] set Lj=@Lj_AVG, LwHd2=@LwHd2_AVG where testDateTime=@testTime and axleNo=@axleNo and wheelNo=@wheelNo
				insert into [tycho_kc].[dbo].[ProfilePatchLog0] values(@testTime,@axleNo,@wheelNo,@carNo,@pos,@diameter, @Lj_AVG)
				fetch next from @cursor_test into @axleNo, @wheelNo,@diameter,@rim_thickness2
			end
			close @cursor_test

			exec [tycho_kc].[dbo].profile_LjCha @testTime
			exec [tycho_kc].[dbo].profile @testTime

		end
END
GO
/****** Object:  StoredProcedure [dbo].[Profile_patch]    Script Date: 06/16/2015 14:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	同轴差报警，与历史关联
-- =============================================
CREATE PROCEDURE [dbo].[Profile_patch] 
@testTime datetime
--WITH ENCRYPTION
AS
declare @Count int
declare @cursor_test cursor
declare @cursor_1 cursor 
declare @axleNo int
declare @wheelNo int
declare @id int
declare @v float
declare @lj_now float
declare @dir int
declare @AxleNum int
declare @pos int
declare @carPos int
declare @carNo varchar(20)
declare @t1 datetime
declare @a1 int
declare @w1 int
declare @v_left float
declare @v_right float
declare @b_left float
declare @b_right float
declare @org_left float
declare @org_right float
declare @pos_left float
declare @pos_right float
declare @haveUpdate int
declare @bzh varchar(20)
BEGIN
	SET NOCOUNT ON;
	set @haveUpdate = 0
    select @Count=count(*) from ProfileDetectResult where testDateTime=@testTime and Level_LjCha_Zhou>0
	if (@Count > 0)
		begin
			delete from [tycho_kc].[dbo].[ProfilePatchLog] where testDateTime=@testTime
		    select @bzh=engNum, @AxleNum = axleNum, @dir=engineDirection  from [tycho_kc].[dbo].detect where testdatetime=@testTime
			set @cursor_test = cursor for select axleNo,wheelNo,lj from ProfileDetectResult where testDateTime=@testTime and Level_LjCha_Zhou>0 order by axleNo,wheelNo
			open @cursor_test 
			fetch next from @cursor_test into @axleNo, @wheelNo,@lj_now
			while(@@fetch_status=0)
			begin
				--print 'axle:'+cast(@axleNo as varchar(10))+ '  wheel:' + cast(@wheelNo as varchar(10)) + '  diameter:'+ cast(@lj_now as varchar(10))
				set @carPos = @axleNo/4
				--print @carPos

				set @pos = [tycho_kc].[dbo].wheelPos(@bzh, @axleNo, @wheelNo, @dir)
				select @carNo=carNo from [tycho_kc].[dbo].CarList where testDateTime=@testTime and posNo=@carPos
				--print @carNo
				--print @pos
				set @cursor_1 = cursor for select top 3 testDateTime,axleNo, wheelNo, lj from ProfileDetectResult_real where testDateTime<@testTime and right(carNo,6)=right(@carNo,6) and pos=@pos order by testDateTime desc
				open @cursor_1 
				fetch next from @cursor_1 into @t1,@a1,@w1,@v
				declare @i int
				declare @v1 float
				declare @v2 float
				declare @v3 float
				set @v1=0
				set @v2=0
				set @v3=0
				set @i=0
				while(@@fetch_status=0)
				begin
				    if (@i=0)
				    begin
						--查最近这次有没报警  有 break
						select @Count=count(*) from ProfileDetectResult where testDateTime=@t1 and axleNo=@a1 and wheelNo=@w1 and Level_LjCha_Zhou>0
						if (@Count > 0)
							break
							
						--查最近这次有没调整  有 break
						select @Count=count(*) from ProfilePatchLog where testDateTime=@t1 and axleNo=@a1 and wheelNo=@w1
						if (@Count > 0)
							break
							
						set @v1 = @v
					end
					else if (@i = 1)
					begin
						set @v2 = @v
					end	
					else if (@i = 2)
					begin
						set @v3 = @v
					end	
			
					fetch next from @cursor_1 into @t1,@a1,@w1,@v
					set @i = @i +1
				end	
				close @cursor_1
				--print @v1
				--print @v2
				--print @v3
				--历史数据少于3次
				if (@v1=0 or @v2=0 or @v3=0)
					break;
				--取中间
				if (@v1>=@v2)
					begin
						if (@v2>=@v3)
							set @v=@v2
						else
						   if (@v1>=@v3)
								set @v=@v3
						   else
						        set @v=@v1
					end
				else
					begin
						if (@v2<=@v3)
							set @v=@v2
						else
						   if (@v1<=@v3)
								set @v=@v3
						   else
						        set @v=@v1
					end
				--print 'middle:'+cast(@v as varchar(10))	
				if (@wheelNo = 0)
					begin
						set @v_left = @v
						set @b_left = ABS(@v-@lj_now)
						set @org_left = @lj_now
						set @pos_left = @pos
					end
				else
					begin
						set @v_right = @v
						set @b_right = ABS(@v-@lj_now)
						set @org_right = @lj_now
						set @pos_right = @pos
						
						--print 'left:'+cast(@v_left as varchar(10))	+ '   ' +cast(@b_left as varchar(10))
						--print 'right:'+cast(@v_right as varchar(10))	+ '   ' +cast(@b_right as varchar(10))
						if (@b_left >@b_right)
							begin
								update ProfileDetectResult set Lj=@v_left where testDateTime=@testTime and axleNo=@axleNo and wheelNo=0
								update ProfileDetectResult_real set Lj_user=@v_left where testDateTime=@testTime and axleNo=@axleNo and wheelNo=0
								insert into ProfilePatchLog values(@testTime,@axleNo,0,@carNo,@pos_left,@org_left, @v_left)
							end
						else if (@b_left < @b_right)
							begin
								update ProfileDetectResult set Lj=@v_right where testDateTime=@testTime and axleNo=@axleNo and wheelNo=1
								update ProfileDetectResult_real set Lj_user=@v_right where testDateTime=@testTime and axleNo=@axleNo and wheelNo=1
								insert into ProfilePatchLog values(@testTime,@axleNo,1,@carNo,@pos_right,@org_right, @v_right)
						    end
						else
							begin
								update ProfileDetectResult set Lj=@v_left where testDateTime=@testTime and axleNo=@axleNo and wheelNo=0
								update ProfileDetectResult_real set Lj_user=@v_left where testDateTime=@testTime and axleNo=@axleNo and wheelNo=0
								insert into ProfilePatchLog values(@testTime,@axleNo,0,@carNo,@pos_left,@org_left, @v_left)
								update ProfileDetectResult set Lj=@v_right where testDateTime=@testTime and axleNo=@axleNo and wheelNo=1
								update ProfileDetectResult_real set Lj_user=@v_right where testDateTime=@testTime and axleNo=@axleNo and wheelNo=1
								insert into ProfilePatchLog values(@testTime,@axleNo,1,@carNo,@pos_right,@org_right, @v_right)
							end
						set @haveUpdate = 1
					end
				fetch next from @cursor_test into @axleNo, @wheelNo,@lj_now
			end
			close @cursor_test
			--需要重算
			if (@haveUpdate >0)
				begin
					exec [tycho_kc].[dbo].profile_LjCha @testTime
					exec [tycho_kc].[dbo].profile @testTime
			    end
		end
END
GO
/****** Object:  StoredProcedure [dbo].[UpdateScatchResultByCarNoSomething]    Script Date: 06/16/2015 14:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**********************************************************************************************
-- 创建：董辉
-- 时间：2014-12-29 15:03
-- 说明：更新擦伤结果中的车号，轮号，级别等
**********************************************************************************************/
create proc [dbo].[UpdateScatchResultByCarNoSomething]
(
	@testDateTime datetime,
	
	@in_EncoderModel int
)

as

begin

	set NOCOUNT ON;
	
	begin tran;
	
	begin TRY
	
		--查找当前日期所有的擦伤数据
		if exists(select testDateTime from ScratchDetectResult where testDateTime = @testDateTime)
			BEGIN
			
				declare @i int;
				declare @TotalCount int;
				set @i = 1;
				set @TotalCount = 0;
				
				declare @Direction bit,
						@engNum	nvarchar(50);
						
				
				--获取进线方向（0反向进线，1正向进线）
				--车组号
				select @Direction = engineDirection,
					   @engNum = (case when engNum = 'unknown' then '未知' else engNum end)
				from   Detect 
				where 
					  testDateTime = @testDateTime;
							  
				DECLARE @ScartchTable table([ID] int not null IDENTITY(1,1), testDateTime datetime,axleNo int,wheelNo int,maxlevel int);
				
				insert into @ScartchTable select testDateTime,axleNo,wheelNo,min(level) [level] from ScratchDetectResult where testDateTime = @testDateTime
				group by ScratchDetectResult.testDateTime,ScratchDetectResult.axleNo,ScratchDetectResult.wheelNo;
				
				select @TotalCount = count(1) from @ScartchTable;
				
				WHILE @i <= @TotalCount
					BEGIN
					
						declare @AxleNo int,
								@Wheel  int,
								@pos    int,
								@carNo  nvarchar(20),
								@maxLevel int;
								
						select @AxleNo = axleNo,@Wheel = wheelNo,@maxLevel = maxlevel from @ScartchTable where [ID] = @i;
								
						if @in_EncoderModel = 2
							BEGIN
							
								--轮位
								select @pos = dbo.GetWheelPos_By_TestDateTime_AxleNo_WheelNo(@testDateTime,@AxleNo,@Wheel);
							
							END
						else 
							BEGIN
							
								--轮位
								select @pos = dbo.wheelPos(@engNum,@AxleNo,@Wheel,@Direction);
							
							END
							
						--车厢号
						select @carNo = dbo.GetCarNoByAxleNo(@testDateTime,@AxleNo);
					
						update ScratchDetectResult set R_CarNo = @carNo,R_pos = @pos,R_level = @maxLevel where testDateTime = @testDateTime and axleNo = @AxleNo and wheelNo = @Wheel;
						
						set @i += 1;
					
					END
			
			end
			
		commit tran;
	
	end TRY
	begin CATCH
	
		rollback tran;
		
		DECLARE @ErrorMessage NVARCHAR(4000);

        DECLARE @ErrorSeverity INT;

        DECLARE @ErrorState INT;

        SELECT  @ErrorMessage = ERROR_MESSAGE(),
                @ErrorSeverity = ERROR_SEVERITY(),
                @ErrorState = ERROR_STATE();
        RAISERROR (@ErrorMessage,1,@ErrorState) WITH LOG;

        RETURN;
	
	end CATCH

end
GO
/****** Object:  StoredProcedure [dbo].[TS_Recent]    Script Date: 06/16/2015 14:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Shenxd
-- Create date: 20150106
-- Description:	指定车轮最近探伤
-- =============================================
CREATE PROCEDURE [dbo].[TS_Recent] 
@carNo varchar(20),
@pos int
--WITH ENCRYPTION
AS

declare @AxleNum int
declare @dir int
declare @cs int
declare @Fcs varchar(2)
declare @czh varchar(20)
BEGIN

declare @t1 table(testdatetime datetime, carNo varchar(20))

declare @s varchar(1000)
set @s = 'select top 30 testDateTime, carNo from CarList where carNo='''+@carNo+''' order by testdatetime desc'
insert into @t1 exec(@s)

declare @t2 table(testdatetime datetime, pos int, tslevel int)
set @s = 'select testdatetime, pos, tslevel from (
SELECT  testdatetime, dbo.GetCarNoByAxleNo(testdatetime, axleNo) carNo, 
        dbo.GetWheelPos_By_TestDateTime_AxleNo_WheelNo(testDateTime, axleNo, wheelNo) pos, 
        min(LEVEL) tslevel
FROM    BugResult
where testdatetime in (select top 30 testDateTime from CarList where carNo='''+@carNo+''' order by testdatetime desc)
GROUP BY testDateTime , axleNo, wheelNo ) a
where carNo = '''+@carNo+''' and pos='+cast(@pos as CHAR(2))

insert into @t2 exec(@s)

select C.testdateTime, isnull(B.tslevel, 0) level, C.CarNo, @pos pos, dbo.[GetAxleNo_By_TestDateTime_CarNo_WheelPos](C.testdateTime, C.carNo, @pos) axleNo
from 
@t1 C
left join
@t2 B
on C.testDateTime=B.testdatetime
order by C.testdateTime desc




END
GO
/****** Object:  StoredProcedure [dbo].[FindDateScoapData]    Script Date: 06/16/2015 14:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**********************************************************************************************
-- 创建：董辉
-- 时间：2014-8-14 16:11
-- 说明：查询前30天历史记录信息（动车专用）
**********************************************************************************************/
create proc [dbo].[FindDateScoapData]
(
	@in_testDateTime datetime,
	
	@in_axle int,
	
	@in_wheel int,
	
	@in_EncoderModel int
)

as

begin

	set NOCOUNT ON;
	
	declare @carNo		nvarchar(20),
			@pos		int,
			@Direction  bit,
			@engNum		nvarchar(50),
			@AxleNum	int,
		    @dir		int,
		    @cs			int,
		    @Fcs		varchar(2),
		    @czh		varchar(20);
	
	--获取进线方向（0反向进线，1正向进线）
	--车组号
	select @Direction = engineDirection,
		   @engNum = (case when engNum = 'unknown' then '未知' else engNum end)
    from   Detect 
	where 
	      testDateTime = @in_testDateTime;

	if @in_EncoderModel = 2
		BEGIN
		
			--轮位
			select @pos = dbo.GetWheelPos_By_TestDateTime_AxleNo_WheelNo(@in_testDateTime,@in_axle,@in_wheel);
		
		END
	else 
		BEGIN
		
			--轮位
			select @pos = dbo.wheelPos(@engNum,@in_axle,@in_wheel,@Direction);
		
		END

	--车厢ID
	select @carNo = dbo.GetCarNoByAxleNo(@in_testDateTime,@in_axle);
	
	declare @t1 table(testdatetime datetime, carNo varchar(20));
	
	insert into @t1 select top 30 testDateTime, carNo from CarList where carNo=''+@carNo+'' order by testdatetime desc;

	declare @t2 table(testDateTime datetime, R_CarNo nvarchar(50),R_pos int,R_level int);
	
	insert into @t2 select top 30 testDateTime,R_CarNo,R_pos,R_level from ScratchDetectResult where R_CarNo=''+@carNo+'' and R_pos= cast(@pos as CHAR(2)) order by testDateTime desc;

	select  a.testdateTime,
			isnull(min(b.R_level),0) [level],
			a.carNo,
			@pos [pos],
			dbo.[GetAxleNo_By_TestDateTime_CarNo_WheelPos](a.testdateTime, a.carNo, @pos) axleNo
	from 
		    @t1 a
	left join
	        @t2 b
	on      a.testDateTime=b.testdatetime
	group by a.testdatetime,a.carNo
	order by a.testdateTime desc;

end
GO
/****** Object:  StoredProcedure [dbo].[FilterCSByThreeTime]    Script Date: 06/16/2015 14:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**********************************************************************************************
-- 创建：董辉
-- 时间：2014-9-18 10:42
-- 说明：过滤同一列车同一轮子有三次及以上的三级伤时(包含此列车的前二次历史记录)
		 变更为二级伤。
**********************************************************************************************/

create proc [dbo].[FilterCSByThreeTime]
(
	@in_TestDateTime datetime --检测时间
)

as

begin

	--不返回受影响行数
	set nocount on;
	
	begin TRY
	
		--有擦伤数据
		if exists(select * from ScratchDetectResult where testDateTime = @in_TestDateTime)
			BEGIN
			
				--定义公用变量
				declare @i				int = 1,		--循环因子
						@CSCount		int,			--擦伤3级数据条数
						@HistoryIndex	int = 1,		--历史记录循环因子
						@HistoryCount	int,			--历史记录数据条数
						@CurrentCarNo   nvarchar(50),   --当前车厢号
						@CurrentDate    datetime,		--当前轮子的日期
						@CurrentAxle	int,			--当前轮子的轴号
						@CurrentWheel   int,			--当前轮子的轮号
						@Direction		bit,			--进线方向
						@engNum			nvarchar(50),	--车组号
						@CurrentPos		int;			--轮位
						
				--定义历史记录临时表
				create table #HistoryTable(
											  [ID]				int IDENTITY(1, 1) not null,
											  [testDateTime]	datetime not null,
											  [posNo]			int not null,
											  [carNo]			nvarchar(100) not null
										  );	
										  		  
				--定义三级表对象
				declare @CSTable table(
										  [ID]				int IDENTITY(1, 1) not null,
										  [testDateTime]	datetime not null,
										  [axleNo]			int not null,
										  [wheelNo]			int not null
									  );
									  
				--当前日期的3级伤数据存入表对象
				insert into @CSTable
				select testDateTime,
					   axleNo,
					   wheelNo 
				from ScratchDetectResult 
				where 
					   testDateTime = @in_TestDateTime
				   and [level] = 3
				group by 
					   testDateTime,
					   axleNo,
					   wheelNo;
					  
				--计算数据条数 
				select @CSCount = count(1) from @CSTable;
				
				--获取进线方向（0反向进线，1正向进线）
				select @Direction = engineDirection 
				from Detect 
				where testDateTime = @in_testDateTime;
				
				--车组号
				SELECT @engNum = (case when engNum = 'unknown' then '未知' else engNum end) 
				from Detect 
				where testDateTime = @in_testDateTime;
				
				--循环擦伤3级数据，找出当前轮子的前2条历史数据
				while @i <= @CSCount
					BEGIN
								  
						--当前轮子的数据
						select 
								@CurrentDate = [testDateTime],
								@CurrentAxle = [axleNo],
								@CurrentWheel = [wheelNo]
						from 
							@CSTable 
						where [ID] = @i;
						
						--当前轴、轮子的轮位
						select @CurrentPos = dbo.wheelPos(@engNum,@CurrentAxle,@CurrentWheel,@Direction);
							
						--查找前3次历史记录信息
						insert into #HistoryTable
						select 
							top 3 testDateTime,posNo,carNo
						from 
							CarList
					    where 
							carNo = dbo.GetCarNoByAxleNo(@CurrentDate,@CurrentAxle)
							
						and testDateTime <= @CurrentDate
						order by 
							testDateTime 
						desc;
						
						declare @temp int;
						
						select @temp = count(1) from #HistoryTable;
						
						--确定当前历史数据数量是否大于或等于3
						if (select count(1) from #HistoryTable) >= 3
							BEGIN
							
								DECLARE @HistoryDate datetime		= null,	--历史记录日期
										@HistoryCarNo nvarchar(100) = '',	--历史记录车厢ID
										@SecondLevel  int			= 0,	--查找到的第2历史记录级别
										@ThreeLevel   int			= 0;	--查找到的第3历史记录级别
								
								--取前第一个历史记录数据
								select @HistoryDate = [testDateTime],
									   @HistoryCarNo = [carNo] 
								from   #HistoryTable 
								where [ID] = 2;
								
								--查找前第一个历史记录数据
								select 
										@SecondLevel = [LEVEL] 
								from 
										TransformToCarData 
								where 
										testDateTime = @HistoryDate 
								and 
										carNo = @HistoryCarNo
										
								and     pos = @CurrentPos;
										
								--取前第二个历史记录数据
								select @HistoryDate = [testDateTime],
									   @HistoryCarNo = [carNo] 
								from   #HistoryTable 
								where [ID] = 3;
								
								--查找前第二个历史记录数据
								select 
										@ThreeLevel = [LEVEL] 
								from 
										TransformToCarData 
								where 
										testDateTime = @HistoryDate 
								and 
										carNo = @HistoryCarNo
										
								and     pos = @CurrentPos;
										
								--前二个历史记录级别都小于等于3更改当前
								--日期、轴号、轮号级别为2
								if (@SecondLevel > 0 and @SecondLevel <= 3) and (@ThreeLevel > 0 and @ThreeLevel <= 3)
									BEGIN
									
										update 
												ScratchDetectResult 
										set		[level] = 2 
										where 
												testDateTime = @CurrentDate 
										and 
												axleNo = @CurrentAxle 
												
										and		wheelNo = @CurrentWheel;
									
									END
							
							END

						TRUNCATE TABLE #HistoryTable;
						
						set @i += 1;
					
					END
			END
	
	end TRY
	
	begin CATCH
	
		DECLARE @ErrorMessage NVARCHAR(4000);

        DECLARE @ErrorSeverity INT;

        DECLARE @ErrorState INT;

        SELECT  @ErrorMessage = ERROR_MESSAGE(),
                @ErrorSeverity = ERROR_SEVERITY(),
                @ErrorState = ERROR_STATE();
        RAISERROR (@ErrorMessage,1,@ErrorState) WITH LOG;

        RETURN;
	
	end CATCH

end
GO
/****** Object:  StoredProcedure [dbo].[Ts_Patch]    Script Date: 06/16/2015 14:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Shenxd
-- Create date: 20140904
-- Description:	连续多次三级报警，提升为二级
-- =============================================
CREATE PROCEDURE [dbo].[Ts_Patch] 
@testDateTime char(20)
--WITH ENCRYPTION
AS

declare @cursor_test cursor 
declare @axleNo int --轴号
declare @wheelNo int
declare @level int
declare @pos int --轮位
declare @carNo varchar(20)
declare @t1 datetime
declare @count int
declare @countOfLevel3 int
declare @NUM_PRE_TEST_LEVEL3 int
BEGIN
	--前两次次三级报警，提升为二级
	set @NUM_PRE_TEST_LEVEL3 = 2
	--本次检测结果为三级的纪录
	set @cursor_test = cursor for select carNo, pos, axleNo, wheelNo from V_TsBugResult where testDateTime=@testDateTime and level=3
	open @cursor_test 
	--车厢号及轮位
	fetch next from @cursor_test into @carNo,@pos, @axleNo, @wheelNo
    while(@@fetch_status=0)
	begin
		--print @carNo
		--print @pos
		--该轮的前2次检测情况
		declare @cursor_history cursor 
		--之前是否已测过2次及以上
		select @count=COUNT(*) from CarList where carNo=@carNo and testdatetime<@testdatetime 
		if (@count >= @NUM_PRE_TEST_LEVEL3)
		begin
			set @countOfLevel3 = 0 --已发现的三级以上次数
			set @cursor_history = cursor for select top (@NUM_PRE_TEST_LEVEL3) testdatetime from CarList where carNo=@carNo and testdatetime<@testdatetime order by testdatetime desc
			open @cursor_history 
			fetch next from @cursor_history into @t1
			while(@@fetch_status=0)
			begin --之前的检测
				set @level = 0
				select @level=level from  V_TsBugResult where testDateTime=@t1 and carno=@carNo and pos=@pos
				--是否有且三级以上
				if (@level>0 and @level<=3)
					set @countOfLevel3 = @countOfLevel3 + 1
				--print @t1
				--print @level
				fetch next from @cursor_history into @t1
			end
			close @cursor_history
			deallocate @cursor_history
			--两次三级以上
			if (@countOfLevel3 = @NUM_PRE_TEST_LEVEL3)
				begin
					--print 'update'
					--三级升为二级
					update BugResult set level=2, desc2=desc2+';连续三级升为二级' where testDateTime=@testDateTime and axleNo=@axleNo and wheelNo=@wheelNo and level=3
				end
		end	
		fetch next from @cursor_test into @carNo,@pos, @axleNo, @wheelNo
	end

	close @cursor_test
	deallocate @cursor_test

end
GO
/****** Object:  StoredProcedure [dbo].[Locomotive_FilterCSByThreeTime]    Script Date: 06/16/2015 14:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**********************************************************************************************
-- 创建：董辉
-- 时间：2014-10-9 13:03
-- 说明：（机车专用,8摆杆）过滤同一列车同一轮子有三次及以上的三级伤时(包含此列车的前二次历史记录)
		  变更为二级伤。
**********************************************************************************************/

create proc [dbo].[Locomotive_FilterCSByThreeTime]
(
	@in_TestDateTime datetime --检测时间
)

as

begin

	--不返回受影响行数
	set nocount on;
	
	begin TRY
	
		--有擦伤数据
		if exists(select * from ScratchDetectResult where testDateTime = @in_TestDateTime)
			BEGIN
			
				--定义公用变量
				declare @i				int = 1,		--循环因子
						@CSCount		int,			--擦伤3级数据条数
						@HistoryIndex	int = 1,		--历史记录循环因子
						@HistoryCount	int,			--历史记录数据条数
						@CurrentCarNo   nvarchar(50),   --当前车厢号
						@CurrentDate    datetime,		--当前轮子的日期
						@CurrentAxle	int,			--当前轮子的轴号
						@CurrentWheel   int,			--当前轮子的轮号
						@Direction		bit,			--进线方向
						@engNum			nvarchar(50),	--车组号
						@CurrentPos		int;			--轮位
						
				--定义历史记录临时表
				create table #HistoryTable(
											  [ID]				int IDENTITY(1, 1) not null,
											  [testDateTime]	datetime not null,
											  [posNo]			int not null,
											  [carNo]			nvarchar(100) not null
										  );	
										  		  
				--定义三级表对象
				declare @CSTable table(
										  [ID]				int IDENTITY(1, 1) not null,
										  [testDateTime]	datetime not null,
										  [axleNo]			int not null,
										  [wheelNo]			int not null
									  );
									  
				--当前日期的3级伤数据存入表对象
				insert into @CSTable
				select testDateTime,
					   axleNo,
					   wheelNo 
				from ScratchDetectResult 
				where 
					   testDateTime = @in_TestDateTime
				   and [level] = 3
				group by 
					   testDateTime,
					   axleNo,
					   wheelNo;
					  
				--计算数据条数 
				select @CSCount = count(1) from @CSTable;
				
				--获取进线方向（0反向进线，1正向进线）
				select @Direction = engineDirection 
				from Detect 
				where testDateTime = @in_testDateTime;
				
				--车组号
				SELECT @engNum = (case when engNum = 'unknown' then '未知' else engNum end) 
				from Detect 
				where testDateTime = @in_testDateTime;
				
				--循环擦伤3级数据，找出当前轮子的前2条历史数据
				while @i <= @CSCount
					BEGIN
								  
						--当前轮子的数据
						select 
								@CurrentDate = [testDateTime],
								@CurrentAxle = [axleNo],
								@CurrentWheel = [wheelNo]
						from 
							@CSTable 
						where [ID] = @i;
						
						--当前轴、轮子的轮位
						select @CurrentPos = dbo.wheelPos(@engNum,@CurrentAxle,@CurrentWheel,@Direction);
							
						--查找前3次历史记录信息
						insert into #HistoryTable
						select 
							top 3 testDateTime,posNo,carNo
						from 
							CarList
					    where 
							carNo = dbo.GetCarNoByAxleNo(@CurrentDate,@CurrentAxle)
							
						and testDateTime <= @CurrentDate
						order by 
							testDateTime 
						desc;
						
						declare @temp int;
						
						select @temp = count(1) from #HistoryTable;
						
						--确定当前历史数据数量是否大于或等于3
						if (select count(1) from #HistoryTable) >= 3
							BEGIN
							
								DECLARE @HistoryDate datetime		= null,	--历史记录日期
										@HistoryCarNo nvarchar(100) = '',	--历史记录车厢ID
										@SecondLevel  int			= 0,	--查找到的第2历史记录级别
										@ThreeLevel   int			= 0;	--查找到的第3历史记录级别
								
								--取前第一个历史记录数据
								select @HistoryDate = [testDateTime],
									   @HistoryCarNo = [carNo] 
								from   #HistoryTable 
								where [ID] = 2;
								
								--查找前第一个历史记录数据
								select 
										@SecondLevel = [LEVEL] 
								from 
										TransformToCarData 
								where 
										testDateTime = @HistoryDate 
								and 
										carNo = @HistoryCarNo
										
								and     pos = @CurrentPos;
										
								--取前第二个历史记录数据
								select @HistoryDate = [testDateTime],
									   @HistoryCarNo = [carNo] 
								from   #HistoryTable 
								where [ID] = 3;
								
								--查找前第二个历史记录数据
								select 
										@ThreeLevel = [LEVEL] 
								from 
										TransformToCarData 
								where 
										testDateTime = @HistoryDate 
								and 
										carNo = @HistoryCarNo
										
								and     pos = @CurrentPos;
										
								--前二个历史记录级别都小于等于3更改当前
								--日期、轴号、轮号级别为2
								if (@SecondLevel > 0 and @SecondLevel <= 3) and (@ThreeLevel > 0 and @ThreeLevel <= 3)
									BEGIN
									
										update 
												ScratchDetectResult 
										set		[level] = 2 
										where 
												testDateTime = @CurrentDate 
										and 
												axleNo = @CurrentAxle 
												
										and		wheelNo = @CurrentWheel;
									
									END
							
							END

						TRUNCATE TABLE #HistoryTable;
						
						set @i += 1;
					
					END
			END
	
	end TRY
	
	begin CATCH
	
		DECLARE @ErrorMessage NVARCHAR(4000);

        DECLARE @ErrorSeverity INT;

        DECLARE @ErrorState INT;

        SELECT  @ErrorMessage = ERROR_MESSAGE(),
                @ErrorSeverity = ERROR_SEVERITY(),
                @ErrorState = ERROR_STATE();
        RAISERROR (@ErrorMessage,1,@ErrorState) WITH LOG;

        RETURN;
	
	end CATCH

end
GO
/****** Object:  StoredProcedure [dbo].[proc1]    Script Date: 06/16/2015 14:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[proc1] 
@testDateTime char(20)

AS
declare @t int
BEGIN
	SET NOCOUNT ON;

	
	exec Ts_Patch @testDateTime
		
		
	select @t = count(distinct axleno)  from bugresult where testdatetime=@testDateTime and level=1
	update detect set redWheelNum = @t where testDateTime=@testDateTime

	select @t = count(distinct axleno)  from bugresult where testdatetime=@testDateTime and level=2
	update detect set yellowWheelNum = @t where testDateTime=@testDateTime

	select @t = count(distinct axleno)  from bugresult where testdatetime=@testDateTime and level=3
	update detect set blueWheelNum = @t where testDateTime=@testDateTime

	select @t = count(distinct axleno)  from bugresult where testdatetime=@testDateTime and level=4
	update detect set greenWheelNum = @t where testDateTime=@testDateTime


END
GO
/****** Object:  StoredProcedure [dbo].[Locomotive_FilterCSBySomeThing]    Script Date: 06/16/2015 14:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**********************************************************************************************
-- 创建：董辉
-- 时间：2014-10-9 12:53
-- 说明：1,（机车专用,8摆杆）过滤重复擦伤
		 2,（机车专用,8摆杆）过滤擦伤位置重合的伤
		 3,（机车专用,8摆杆）同一列车同一轮子出现三次及以上的三级伤，更改为二级伤
**********************************************************************************************/

create proc [dbo].[Locomotive_FilterCSBySomeThing]
(
	@in_TestDateTime datetime, --检测时间
	
	@in_EncoderModel int,	   --编码模式（0：双编码，1：单编码）
	
	@in_OperationMode int,	   --运行模式（0单轮，1列车）
	
	@out_Result int = 1 output --操作结果（0失败，1成功）
)

as

begin

	--不返回受影响行数
	set nocount on;
	
	begin try
		
		if exists(select testDateTime from ScratchDetectResult where testDateTime = @in_TestDateTime)
			begin
			
			--定义变量
			declare @index int = 1,						--循环因子
					@CurrentData_Varchar varchar(100),	--当前数据，字符型
					@CurrentData_int int,				--当前数据，整形
					@AxleTotablCount int,				--轴总行数
					@CSTotalCount int;					--擦伤总行数
			
			--定义擦伤表对象
			declare @CSTable table(
									  [testDateTime] datetime not null,
									  [axleNo] int not null,
									  [wheelNo] int not null,
									  [temp] nvarchar(50) not null,
									  [scratch_depth] float not null,
									  [swingNo] tinyint
								   );
								   
			--获取指定日期的所有擦伤数据
			insert into @CSTable select [testDateTime],
										[axleNo],
										[wheelNo],
										[temp],
										[scratch_depth],
										[swingNo] 
								from ScratchDetectResult 
								where testDateTime = @in_TestDateTime;
								
			--查询擦伤总行数
			select @CSTotalCount = COUNT(1) from @CSTable;
									   	
			--定义轴号表对象	
			declare @AxleNumTable table([ID] int IDENTITY(1, 1) not null,[axleNo] int not null);
			
			--获取指定日期的所有轴号数据
			insert into @AxleNumTable select axleNo from ScratchDetectResult 
			where testDateTime = @in_TestDateTime group by axleNo;
			
			--查询轴号总行数
			select @AxleTotablCount = COUNT(1) from @AxleNumTable;
			
			----------------------------------过滤摆杆上有多个伤时只保留深度最大的一个，其它去除------------------------------
			
			--双编码
			if @in_EncoderModel = 0
				begin
				
					--分批次找出相应的轴号对应的擦伤数据
					while @index <= @AxleTotablCount
						begin
						
							select @CurrentData_int = [axleNo] from @AxleNumTable where [ID] = @index;
							
							--左轮1摆杆
							delete scratchDetectResult where testDateTime = @in_TestDateTime
							and [axleNo] = @CurrentData_int
						    and ([swingNo] = 0 or [swingNo] = 2) 
						    and temp <>
							(
								select top 1 [temp] from @CSTable 
								where [axleNo] = @CurrentData_int 
									  and ([swingNo] = 0 or [swingNo] = 2) 
								order by [scratch_depth] desc,[temp] desc
							)
								
							--左轮2摆杆
							delete scratchDetectResult where testDateTime = @in_TestDateTime
							and [axleNo] = @CurrentData_int
						    and ([swingNo] = 4 or [swingNo] = 6) 
						    and temp <>
							(
								select top 1 [temp] from @CSTable 
								where [axleNo] = @CurrentData_int 
									  and ([swingNo] = 4 or [swingNo] = 6) 
								order by [scratch_depth] desc,[temp] desc
							)
							
							--左轮3摆杆
							delete scratchDetectResult where testDateTime = @in_TestDateTime
							and [axleNo] = @CurrentData_int
						    and ([swingNo] = 8 or [swingNo] = 10) 
						    and temp <>
							(
								select top 1 [temp] from @CSTable 
								where [axleNo] = @CurrentData_int 
									  and ([swingNo] = 8 or [swingNo] = 10) 
								order by [scratch_depth] desc,[temp] desc
							)
							
							--左轮4摆杆
							delete scratchDetectResult where testDateTime = @in_TestDateTime
							and [axleNo] = @CurrentData_int
						    and ([swingNo] = 12 or [swingNo] = 14) 
						    and temp <>
							(
								select top 1 [temp] from @CSTable 
								where [axleNo] = @CurrentData_int 
									  and ([swingNo] = 12 or [swingNo] = 14) 
								order by [scratch_depth] desc,[temp] desc
							)
							
							--右轮1摆杆
							delete scratchDetectResult where testDateTime = @in_TestDateTime
							and [axleNo] = @CurrentData_int
						    and ([swingNo] = 1 or [swingNo] = 3) 
						    and temp <>
							(
								select top 1 [temp] from @CSTable 
								where [axleNo] = @CurrentData_int 
									  and ([swingNo] = 1 or [swingNo] = 3) 
								order by [scratch_depth] desc,[temp] desc
							)
							
							--右轮2摆杆
							delete scratchDetectResult where testDateTime = @in_TestDateTime
							and [axleNo] = @CurrentData_int
						    and ([swingNo] = 5 or [swingNo] = 7) 
						    and temp <>
							(
								select top 1 [temp] from @CSTable 
								where [axleNo] = @CurrentData_int 
									  and ([swingNo] = 5 or [swingNo] = 7) 
								order by [scratch_depth] desc,[temp] desc
							)
							
							--右轮3摆杆
							delete scratchDetectResult where testDateTime = @in_TestDateTime
							and [axleNo] = @CurrentData_int
						    and ([swingNo] = 9 or [swingNo] = 11) 
						    and temp <>
							(
								select top 1 [temp] from @CSTable 
								where [axleNo] = @CurrentData_int 
									  and ([swingNo] = 9 or [swingNo] = 11) 
								order by [scratch_depth] desc,[temp] desc
							)
							
							--右轮4摆杆
							delete scratchDetectResult where testDateTime = @in_TestDateTime
							and [axleNo] = @CurrentData_int
						    and ([swingNo] = 13 or [swingNo] = 15) 
						    and temp <>
							(
								select top 1 [temp] from @CSTable 
								where [axleNo] = @CurrentData_int 
									  and ([swingNo] = 13 or [swingNo] = 15) 
								order by [scratch_depth] desc,[temp] desc
							)
							
							set @index += 1;
						
						end
					
				end
			--单编码
			else if @in_EncoderModel = 1
				begin
				
					--分批次找出相应的轴号对应的擦伤数据
					while @index <= @AxleTotablCount
						begin
						
							select @CurrentData_int = [axleNo] from @AxleNumTable where [ID] = @index;
							
							--左轮1摆杆
							delete scratchDetectResult where testDateTime = @in_TestDateTime
							and [axleNo] = @CurrentData_int
							and [wheelNo] = 0
						    and [swingNo] = 0
						    and temp <>
							(
								select top 1 [temp] from @CSTable 
								where [axleNo] = @CurrentData_int 
									  and [wheelNo] = 0
									  and [swingNo] = 0
								order by [scratch_depth] desc,[temp] desc
							)
								
							--左轮2摆杆
							delete scratchDetectResult where testDateTime = @in_TestDateTime
							and [axleNo] = @CurrentData_int
							and [wheelNo] = 0
						    and [swingNo] = 1
						    and temp <>
							(
								select top 1 [temp] from @CSTable 
								where [axleNo] = @CurrentData_int 
									  and [wheelNo] = 0
									  and [swingNo] = 1
								order by [scratch_depth] desc,[temp] desc
							)
							
							--左轮3摆杆
							delete scratchDetectResult where testDateTime = @in_TestDateTime
							and [axleNo] = @CurrentData_int
							and [wheelNo] = 0
						    and [swingNo] = 2
						    and temp <>
							(
								select top 1 [temp] from @CSTable 
								where [axleNo] = @CurrentData_int 
									  and [wheelNo] = 0
									  and [swingNo] = 2
								order by [scratch_depth] desc,[temp] desc
							)
							
							--右轮1摆杆
							delete scratchDetectResult where testDateTime = @in_TestDateTime
							and [axleNo] = @CurrentData_int
							and [wheelNo] = 1
						    and [swingNo] = 0
						    and temp <>
							(
								select top 1 [temp] from @CSTable 
								where [axleNo] = @CurrentData_int 
									  and [wheelNo] = 1
									  and [swingNo] = 0
								order by [scratch_depth] desc,[temp] desc
							)
							
							--右轮2摆杆
							delete scratchDetectResult where testDateTime = @in_TestDateTime
							and [axleNo] = @CurrentData_int
							and [wheelNo] = 1
						    and [swingNo] = 1
						    and temp <>
							(
								select top 1 [temp] from @CSTable 
								where [axleNo] = @CurrentData_int 
									  and [wheelNo] = 1
									  and [swingNo] = 1
								order by [scratch_depth] desc,[temp] desc
							)
							
							--右轮3摆杆
							delete scratchDetectResult where testDateTime = @in_TestDateTime
							and [axleNo] = @CurrentData_int
							and [wheelNo] = 1
						    and [swingNo] = 2
						    and temp <>
							(
								select top 1 [temp] from @CSTable 
								where [axleNo] = @CurrentData_int 
									  and [wheelNo] = 1
									  and [swingNo] = 2
								order by [scratch_depth] desc,[temp] desc
							)
							
							set @index += 1;
						
						end
				
				end
			
			if @in_OperationMode = 1
				BEGIN
				
					----------------------------------过滤多个轮子在同一摆杆上擦伤位置有重合的伤-----------------------
					exec Locomotive_FilterCSByCoincidenceLocation @in_TestDateTime,@in_EncoderModel;
					
					------------------------------同一列车同一轮子出现三次以上三级伤，更改为2二级伤---------------------
					exec Locomotive_FilterCSByThreeTime @in_TestDateTime;
					
				END
			
			-------------------------------删除擦伤结果表，一个轮子只保留一个伤---------------------
			delete b from ScratchDetectResult b,
					(
						select 
							max(a.testDateTime) testDateTime, 
							a.axleNo,a.wheelNo,
							max(a.scratch_depth) depth 
						from ScratchDetectResult a 
						where 
							a.testDateTime = @in_TestDateTime
						group by a.axleNo,a.wheelNo
					) c
					where 
						b.testDateTime = c.testDateTime  
						and b.axleNo = c.axleNo 
						and b.wheelNo = c.wheelNo 
						and b.scratch_depth <> c.depth;	
						
			-------------------------------查询并更新擦伤结果表中的车号，轮位等信息---------------------
			exec UpdateScatchResultByCarNoSomething @in_TestDateTime,@in_EncoderModel;	
			
			end
			
		set @out_Result = 1;
	
	end try
	
	begin catch
	
		set @out_Result = 0;
		
		DECLARE @ErrorMessage NVARCHAR(4000);

        DECLARE @ErrorSeverity INT;

        DECLARE @ErrorState INT;

        SELECT  @ErrorMessage = ERROR_MESSAGE(),
                @ErrorSeverity = ERROR_SEVERITY(),
                @ErrorState = ERROR_STATE();
        RAISERROR (@ErrorMessage,1,@ErrorState) WITH LOG;

        RETURN;
	
	end catch

end
GO
/****** Object:  StoredProcedure [dbo].[FilterCSBySomeThing]    Script Date: 06/16/2015 14:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**********************************************************************************************
-- 创建：董辉
-- 时间：2014-9-14 13:19
-- 说明：1,过滤重复擦伤
		 2,过滤擦伤位置重合的伤
		 3,同一列车同一轮子出现三次及以上的三级伤，更改为二级伤
**********************************************************************************************/

create proc [dbo].[FilterCSBySomeThing]
(
	@in_TestDateTime datetime, --检测时间
	
	@in_EncoderModel int,	   --编码模式（0：双编码，1：单编码）
	
	@in_OperationMode int,	   --运行模式（0单轮，1列车）
	
	@out_Result int = 1 output --操作结果（0失败，1成功）
)

as

begin

	--不返回受影响行数
	set nocount on;
	
	begin try
		
		if exists(select testDateTime from ScratchDetectResult where testDateTime = @in_TestDateTime)
			begin
			
			--定义变量
			declare @index int = 1,						--循环因子
					@CurrentData_Varchar varchar(100),	--当前数据，字符型
					@CurrentData_int int,				--当前数据，整形
					@AxleTotablCount int,				--轴总行数
					@CSTotalCount int;					--擦伤总行数
			
			--定义擦伤表对象
			declare @CSTable table(
									  [testDateTime] datetime not null,
									  [axleNo] int not null,
									  [wheelNo] int not null,
									  [temp] nvarchar(50) not null,
									  [scratch_depth] float not null,
									  [swingNo] tinyint
								   );
								   
			--获取指定日期的所有擦伤数据
			insert into @CSTable select [testDateTime],
										[axleNo],
										[wheelNo],
										[temp],
										[scratch_depth],
										[swingNo] 
								from ScratchDetectResult 
								where testDateTime = @in_TestDateTime;
								
			--查询擦伤总行数
			select @CSTotalCount = COUNT(1) from @CSTable;
									   	
			--定义轴号表对象	
			declare @AxleNumTable table([ID] int IDENTITY(1, 1) not null,[axleNo] int not null);
			
			--获取指定日期的所有轴号数据
			insert into @AxleNumTable select axleNo from ScratchDetectResult 
			where testDateTime = @in_TestDateTime group by axleNo;
			
			--查询轴号总行数
			select @AxleTotablCount = COUNT(1) from @AxleNumTable;
			
			----------------------------------过滤摆杆上有多个伤时只保留深度最大的一个，其它去除------------------------------
			
			--双编码
			if @in_EncoderModel = 0
				begin
				
					--分批次找出相应的轴号对应的擦伤数据
					while @index <= @AxleTotablCount
						begin
						
							select @CurrentData_int = [axleNo] from @AxleNumTable where [ID] = @index;
							
							--左轮1摆杆
							delete scratchDetectResult where testDateTime = @in_TestDateTime
							and [axleNo] = @CurrentData_int
						    and ([swingNo] = 0 or [swingNo] = 2) 
						    and temp <>
							(
								select top 1 [temp] from @CSTable 
								where [axleNo] = @CurrentData_int 
									  and ([swingNo] = 0 or [swingNo] = 2) 
								order by [scratch_depth] desc,[temp] desc
							)
								
							--左轮2摆杆
							delete scratchDetectResult where testDateTime = @in_TestDateTime
							and [axleNo] = @CurrentData_int
						    and ([swingNo] = 4 or [swingNo] = 6) 
						    and temp <>
							(
								select top 1 [temp] from @CSTable 
								where [axleNo] = @CurrentData_int 
									  and ([swingNo] = 4 or [swingNo] = 6) 
								order by [scratch_depth] desc,[temp] desc
							)
							
							--左轮3摆杆
							delete scratchDetectResult where testDateTime = @in_TestDateTime
							and [axleNo] = @CurrentData_int
						    and ([swingNo] = 8 or [swingNo] = 10) 
						    and temp <>
							(
								select top 1 [temp] from @CSTable 
								where [axleNo] = @CurrentData_int 
									  and ([swingNo] = 8 or [swingNo] = 10) 
								order by [scratch_depth] desc,[temp] desc
							)
							
							--右轮1摆杆
							delete scratchDetectResult where testDateTime = @in_TestDateTime
							and [axleNo] = @CurrentData_int
						    and ([swingNo] = 1 or [swingNo] = 3) 
						    and temp <>
							(
								select top 1 [temp] from @CSTable 
								where [axleNo] = @CurrentData_int 
									  and ([swingNo] = 1 or [swingNo] = 3) 
								order by [scratch_depth] desc,[temp] desc
							)
							
							--右轮2摆杆
							delete scratchDetectResult where testDateTime = @in_TestDateTime
							and [axleNo] = @CurrentData_int
						    and ([swingNo] = 5 or [swingNo] = 7) 
						    and temp <>
							(
								select top 1 [temp] from @CSTable 
								where [axleNo] = @CurrentData_int 
									  and ([swingNo] = 5 or [swingNo] = 7) 
								order by [scratch_depth] desc,[temp] desc
							)
							
							--右轮3摆杆
							delete scratchDetectResult where testDateTime = @in_TestDateTime
							and [axleNo] = @CurrentData_int
						    and ([swingNo] = 9 or [swingNo] = 11) 
						    and temp <>
							(
								select top 1 [temp] from @CSTable 
								where [axleNo] = @CurrentData_int 
									  and ([swingNo] = 9 or [swingNo] = 11) 
								order by [scratch_depth] desc,[temp] desc
							)
							
							set @index += 1;
						
						end
					
				end
			--单编码
			else if @in_EncoderModel = 1
				begin
				
					--分批次找出相应的轴号对应的擦伤数据
					while @index <= @AxleTotablCount
						begin
						
							select @CurrentData_int = [axleNo] from @AxleNumTable where [ID] = @index;
							
							--左轮1摆杆
							delete scratchDetectResult where testDateTime = @in_TestDateTime
							and [axleNo] = @CurrentData_int
							and [wheelNo] = 0
						    and [swingNo] = 0
						    and temp <>
							(
								select top 1 [temp] from @CSTable 
								where [axleNo] = @CurrentData_int 
									  and [wheelNo] = 0
									  and [swingNo] = 0
								order by [scratch_depth] desc,[temp] desc
							)
								
							--左轮2摆杆
							delete scratchDetectResult where testDateTime = @in_TestDateTime
							and [axleNo] = @CurrentData_int
							and [wheelNo] = 0
						    and [swingNo] = 1
						    and temp <>
							(
								select top 1 [temp] from @CSTable 
								where [axleNo] = @CurrentData_int 
									  and [wheelNo] = 0
									  and [swingNo] = 1
								order by [scratch_depth] desc,[temp] desc
							)
							
							--左轮3摆杆
							delete scratchDetectResult where testDateTime = @in_TestDateTime
							and [axleNo] = @CurrentData_int
							and [wheelNo] = 0
						    and [swingNo] = 2
						    and temp <>
							(
								select top 1 [temp] from @CSTable 
								where [axleNo] = @CurrentData_int 
									  and [wheelNo] = 0
									  and [swingNo] = 2
								order by [scratch_depth] desc,[temp] desc
							)
							
							--右轮1摆杆
							delete scratchDetectResult where testDateTime = @in_TestDateTime
							and [axleNo] = @CurrentData_int
							and [wheelNo] = 1
						    and [swingNo] = 0
						    and temp <>
							(
								select top 1 [temp] from @CSTable 
								where [axleNo] = @CurrentData_int 
									  and [wheelNo] = 1
									  and [swingNo] = 0
								order by [scratch_depth] desc,[temp] desc
							)
							
							--右轮2摆杆
							delete scratchDetectResult where testDateTime = @in_TestDateTime
							and [axleNo] = @CurrentData_int
							and [wheelNo] = 1
						    and [swingNo] = 1
						    and temp <>
							(
								select top 1 [temp] from @CSTable 
								where [axleNo] = @CurrentData_int 
									  and [wheelNo] = 1
									  and [swingNo] = 1
								order by [scratch_depth] desc,[temp] desc
							)
							
							--右轮3摆杆
							delete scratchDetectResult where testDateTime = @in_TestDateTime
							and [axleNo] = @CurrentData_int
							and [wheelNo] = 1
						    and [swingNo] = 2
						    and temp <>
                (
                select top 1 [temp] from @CSTable
                where [axleNo] = @CurrentData_int
                and [wheelNo] = 1
                and [swingNo] = 2
                order by [scratch_depth] desc,[temp] desc
                )

                set @index += 1;

                end

                end

                --列车模式执行以下过滤
                --单轮模式不需要执行
                if @in_OperationMode = 1
                BEGIN

                ----------------------------------过滤多个轮子在同一摆杆上擦伤位置有重合的伤-----------------------
                exec FilterCSByCoincidenceLocation @in_TestDateTime,@in_EncoderModel;

                ------------------------------同一列车同一轮子出现三次以上三级伤，更改为2二级伤---------------------
                exec FilterCSByThreeTime @in_TestDateTime;

                END

                ----------------------------------过滤一个轮子只有一个伤，其它删除-----------------------
                delete a from ScratchDetectResult a JOIN
                (
                select max(testDateTime) testDateTime,
                axleNo,
                wheelNo,
                max(scratch_depth) scratch_depth,
                max(temp) temp,
                count(1) counts
                from ScratchDetectResult
                where testDateTime = @in_TestDateTime
                group by axleNo,wheelNo
                HAVING count(1) > 1
                ) b
                on a.testDateTime = b.testDateTime
                and a.axleNo = b.axleNo
                and a.wheelNo = b.wheelNo
                and a.temp <> b.temp;
                
                -------------------------------查询并更新擦伤结果表中的车号，轮位等信息---------------------
			    exec UpdateScatchResultByCarNoSomething @in_TestDateTime,@in_EncoderModel;	

                end

                set @out_Result = 1;

                end try

                begin catch

                set @out_Result = 0;

                DECLARE @ErrorMessage NVARCHAR(4000);

                DECLARE @ErrorSeverity INT;

                DECLARE @ErrorState INT;

                SELECT  @ErrorMessage = ERROR_MESSAGE(),
                @ErrorSeverity = ERROR_SEVERITY(),
                @ErrorState = ERROR_STATE();
                RAISERROR (@ErrorMessage,1,@ErrorState) WITH LOG;

                RETURN;

                end catch

                end
GO
/****** Object:  Default [DF_BugResult_IsBug]    Script Date: 06/16/2015 14:50:42 ******/
ALTER TABLE [dbo].[BugResult] ADD  CONSTRAINT [DF_BugResult_IsBug]  DEFAULT ((1)) FOR [IsBug]
GO
/****** Object:  Default [DF_CRH_Car_dir]    Script Date: 06/16/2015 14:50:42 ******/
ALTER TABLE [dbo].[CRH_Car] ADD  CONSTRAINT [DF_CRH_Car_dir]  DEFAULT ((1)) FOR [dir]
GO
/****** Object:  Default [DF_Detect_engineDirection]    Script Date: 06/16/2015 14:50:42 ******/
ALTER TABLE [dbo].[Detect] ADD  CONSTRAINT [DF_Detect_engineDirection]  DEFAULT ((1)) FOR [engineDirection]
GO
/****** Object:  Default [DF_Detect_isView]    Script Date: 06/16/2015 14:50:42 ******/
ALTER TABLE [dbo].[Detect] ADD  CONSTRAINT [DF_Detect_isView]  DEFAULT ((0)) FOR [isView]
GO
/****** Object:  Default [DF_Detect_IsTypical]    Script Date: 06/16/2015 14:50:42 ******/
ALTER TABLE [dbo].[Detect] ADD  CONSTRAINT [DF_Detect_IsTypical]  DEFAULT ((0)) FOR [IsTypical]
GO
/****** Object:  Default [DF_ProcData_BeginTime]    Script Date: 06/16/2015 14:50:42 ******/
ALTER TABLE [dbo].[ProcData] ADD  CONSTRAINT [DF_ProcData_BeginTime]  DEFAULT (NULL) FOR [BeginTime]
GO
/****** Object:  Default [DF_ProcData_EndTime]    Script Date: 06/16/2015 14:50:42 ******/
ALTER TABLE [dbo].[ProcData] ADD  CONSTRAINT [DF_ProcData_EndTime]  DEFAULT (NULL) FOR [EndTime]
GO
/****** Object:  Default [DF_ProcData_UseNewWheelSize]    Script Date: 06/16/2015 14:50:42 ******/
ALTER TABLE [dbo].[ProcData] ADD  CONSTRAINT [DF_ProcData_UseNewWheelSize]  DEFAULT ((0)) FOR [UseNewWheelSize]
GO
/****** Object:  Default [DF_ProfileAdjust_Lj]    Script Date: 06/16/2015 14:50:42 ******/
ALTER TABLE [dbo].[ProfileAdjust] ADD  CONSTRAINT [DF_ProfileAdjust_Lj]  DEFAULT ((0)) FOR [Lj]
GO
/****** Object:  Default [DF_ProfileAdjust_LyHd]    Script Date: 06/16/2015 14:50:42 ******/
ALTER TABLE [dbo].[ProfileAdjust] ADD  CONSTRAINT [DF_ProfileAdjust_LyHd]  DEFAULT ((0)) FOR [LyHd]
GO
/****** Object:  Default [DF_ProfileAdjust_LyGd]    Script Date: 06/16/2015 14:50:42 ******/
ALTER TABLE [dbo].[ProfileAdjust] ADD  CONSTRAINT [DF_ProfileAdjust_LyGd]  DEFAULT ((0)) FOR [LyGd]
GO
/****** Object:  Default [DF_ProfileAdjust_LwHd]    Script Date: 06/16/2015 14:50:42 ******/
ALTER TABLE [dbo].[ProfileAdjust] ADD  CONSTRAINT [DF_ProfileAdjust_LwHd]  DEFAULT ((0)) FOR [LwHd]
GO
/****** Object:  Default [DF_ProfileAdjust_LwHd2]    Script Date: 06/16/2015 14:50:42 ******/
ALTER TABLE [dbo].[ProfileAdjust] ADD  CONSTRAINT [DF_ProfileAdjust_LwHd2]  DEFAULT ((0)) FOR [LwHd2]
GO
/****** Object:  Default [DF_ProfileAdjust_QR]    Script Date: 06/16/2015 14:50:42 ******/
ALTER TABLE [dbo].[ProfileAdjust] ADD  CONSTRAINT [DF_ProfileAdjust_QR]  DEFAULT ((0)) FOR [QR]
GO
/****** Object:  Default [DF_ProfileAdjust_Ncj]    Script Date: 06/16/2015 14:50:42 ******/
ALTER TABLE [dbo].[ProfileAdjust] ADD  CONSTRAINT [DF_ProfileAdjust_Ncj]  DEFAULT ((0)) FOR [Ncj]
GO
/****** Object:  Default [DF_ProfileDetectResult_Level_lj]    Script Date: 06/16/2015 14:50:42 ******/
ALTER TABLE [dbo].[ProfileDetectResult] ADD  CONSTRAINT [DF_ProfileDetectResult_Level_lj]  DEFAULT ((0)) FOR [Level_lj]
GO
/****** Object:  Default [DF_ProfileDetectResult_Level_tmmh]    Script Date: 06/16/2015 14:50:42 ******/
ALTER TABLE [dbo].[ProfileDetectResult] ADD  CONSTRAINT [DF_ProfileDetectResult_Level_tmmh]  DEFAULT ((0)) FOR [Level_tmmh]
GO
/****** Object:  Default [DF_ProfileDetectResult_Level_lyhd]    Script Date: 06/16/2015 14:50:42 ******/
ALTER TABLE [dbo].[ProfileDetectResult] ADD  CONSTRAINT [DF_ProfileDetectResult_Level_lyhd]  DEFAULT ((0)) FOR [Level_lyhd]
GO
/****** Object:  Default [DF_ProfileDetectResult_Level_lwhd]    Script Date: 06/16/2015 14:50:42 ******/
ALTER TABLE [dbo].[ProfileDetectResult] ADD  CONSTRAINT [DF_ProfileDetectResult_Level_lwhd]  DEFAULT ((0)) FOR [Level_lwhd]
GO
/****** Object:  Default [DF_ProfileDetectResult_Level_ncj]    Script Date: 06/16/2015 14:50:42 ******/
ALTER TABLE [dbo].[ProfileDetectResult] ADD  CONSTRAINT [DF_ProfileDetectResult_Level_ncj]  DEFAULT ((0)) FOR [Level_ncj]
GO
/****** Object:  Default [DF_ProfileDetectResult_Level_lygd]    Script Date: 06/16/2015 14:50:42 ******/
ALTER TABLE [dbo].[ProfileDetectResult] ADD  CONSTRAINT [DF_ProfileDetectResult_Level_lygd]  DEFAULT ((0)) FOR [Level_lygd]
GO
/****** Object:  Default [DF_ProfileDetectResult_Level_qr]    Script Date: 06/16/2015 14:50:42 ******/
ALTER TABLE [dbo].[ProfileDetectResult] ADD  CONSTRAINT [DF_ProfileDetectResult_Level_qr]  DEFAULT ((0)) FOR [Level_qr]
GO
/****** Object:  Default [DF_ScratchDetectResult_temp]    Script Date: 06/16/2015 14:50:42 ******/
ALTER TABLE [dbo].[ScratchDetectResult] ADD  CONSTRAINT [DF_ScratchDetectResult_temp]  DEFAULT (newid()) FOR [temp]
GO
/****** Object:  Default [DF_ScratchDetectResult_IsBug]    Script Date: 06/16/2015 14:50:42 ******/
ALTER TABLE [dbo].[ScratchDetectResult] ADD  CONSTRAINT [DF_ScratchDetectResult_IsBug]  DEFAULT ((1)) FOR [IsBug]
GO
/****** Object:  Default [DF_UploadToInfoSystem_isUpload]    Script Date: 06/16/2015 14:50:42 ******/
ALTER TABLE [dbo].[UploadToInfoSystem] ADD  CONSTRAINT [DF_UploadToInfoSystem_isUpload]  DEFAULT ((0)) FOR [needUpload]
GO
/****** Object:  ForeignKey [FK_BUG_BUG_DETEC_DETECTOR]    Script Date: 06/16/2015 14:50:42 ******/
ALTER TABLE [dbo].[Bug]  WITH CHECK ADD  CONSTRAINT [FK_BUG_BUG_DETEC_DETECTOR] FOREIGN KEY([detectorType])
REFERENCES [dbo].[DetectorTypeLib] ([id])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[Bug] CHECK CONSTRAINT [FK_BUG_BUG_DETEC_DETECTOR]
GO
/****** Object:  ForeignKey [FK_BUG_BUG_LIST_DETECT]    Script Date: 06/16/2015 14:50:42 ******/
ALTER TABLE [dbo].[Bug]  WITH CHECK ADD  CONSTRAINT [FK_BUG_BUG_LIST_DETECT] FOREIGN KEY([testDateTime])
REFERENCES [dbo].[Detect] ([testDateTime])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Bug] CHECK CONSTRAINT [FK_BUG_BUG_LIST_DETECT]
GO
/****** Object:  ForeignKey [FK_BUGRESUL_RESULT_LI_DETECT]    Script Date: 06/16/2015 14:50:42 ******/
ALTER TABLE [dbo].[BugResult]  WITH CHECK ADD  CONSTRAINT [FK_BUGRESUL_RESULT_LI_DETECT] FOREIGN KEY([testDateTime])
REFERENCES [dbo].[Detect] ([testDateTime])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[BugResult] CHECK CONSTRAINT [FK_BUGRESUL_RESULT_LI_DETECT]
GO
/****** Object:  ForeignKey [FK_CarList_Detect]    Script Date: 06/16/2015 14:50:42 ******/
ALTER TABLE [dbo].[CarList]  WITH CHECK ADD  CONSTRAINT [FK_CarList_Detect] FOREIGN KEY([testDateTime])
REFERENCES [dbo].[Detect] ([testDateTime])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CarList] CHECK CONSTRAINT [FK_CarList_Detect]
GO
/****** Object:  ForeignKey [FK_CarriageInfo_TrainInfo]    Script Date: 06/16/2015 14:50:42 ******/
ALTER TABLE [dbo].[CarriageInfo]  WITH NOCHECK ADD  CONSTRAINT [FK_CarriageInfo_TrainInfo] FOREIGN KEY([TrainID])
REFERENCES [dbo].[TrainInfo] ([TrainID])
GO
ALTER TABLE [dbo].[CarriageInfo] CHECK CONSTRAINT [FK_CarriageInfo_TrainInfo]
GO
/****** Object:  ForeignKey [FK_CheckTime_Detect]    Script Date: 06/16/2015 14:50:42 ******/
ALTER TABLE [dbo].[CheckTime]  WITH CHECK ADD  CONSTRAINT [FK_CheckTime_Detect] FOREIGN KEY([testDateTime])
REFERENCES [dbo].[Detect] ([testDateTime])
GO
ALTER TABLE [dbo].[CheckTime] CHECK CONSTRAINT [FK_CheckTime_Detect]
GO
/****** Object:  ForeignKey [FK_CSSequ_Detect]    Script Date: 06/16/2015 14:50:42 ******/
ALTER TABLE [dbo].[CSSequ]  WITH CHECK ADD  CONSTRAINT [FK_CSSequ_Detect] FOREIGN KEY([testDateTime])
REFERENCES [dbo].[Detect] ([testDateTime])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CSSequ] CHECK CONSTRAINT [FK_CSSequ_Detect]
GO
/****** Object:  ForeignKey [FK_Diameter_Detect]    Script Date: 06/16/2015 14:50:42 ******/
ALTER TABLE [dbo].[Diameter]  WITH CHECK ADD  CONSTRAINT [FK_Diameter_Detect] FOREIGN KEY([testDateTime])
REFERENCES [dbo].[Detect] ([testDateTime])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Diameter] CHECK CONSTRAINT [FK_Diameter_Detect]
GO
/****** Object:  ForeignKey [FK_ENGINE_ENGINE_EN_ENGINELI]    Script Date: 06/16/2015 14:50:42 ******/
ALTER TABLE [dbo].[Engine]  WITH CHECK ADD  CONSTRAINT [FK_ENGINE_ENGINE_EN_ENGINELI] FOREIGN KEY([id])
REFERENCES [dbo].[EngineLib] ([id])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[Engine] CHECK CONSTRAINT [FK_ENGINE_ENGINE_EN_ENGINELI]
GO
/****** Object:  ForeignKey [FK_ENGINELI_ENGINELIB_ENGINETY]    Script Date: 06/16/2015 14:50:42 ******/
ALTER TABLE [dbo].[EngineLib]  WITH CHECK ADD  CONSTRAINT [FK_ENGINELI_ENGINELIB_ENGINETY] FOREIGN KEY([typeId])
REFERENCES [dbo].[EngineTypeLib] ([id])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[EngineLib] CHECK CONSTRAINT [FK_ENGINELI_ENGINELIB_ENGINETY]
GO
/****** Object:  ForeignKey [FK_ENGINELI_ENGINELIB_FACTORYL]    Script Date: 06/16/2015 14:50:42 ******/
ALTER TABLE [dbo].[EngineLib]  WITH CHECK ADD  CONSTRAINT [FK_ENGINELI_ENGINELIB_FACTORYL] FOREIGN KEY([factoryId])
REFERENCES [dbo].[FactoryLib] ([id])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[EngineLib] CHECK CONSTRAINT [FK_ENGINELI_ENGINELIB_FACTORYL]
GO
/****** Object:  ForeignKey [FK_ProcData_Detect]    Script Date: 06/16/2015 14:50:42 ******/
ALTER TABLE [dbo].[ProcData]  WITH CHECK ADD  CONSTRAINT [FK_ProcData_Detect] FOREIGN KEY([testDateTime])
REFERENCES [dbo].[Detect] ([testDateTime])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ProcData] CHECK CONSTRAINT [FK_ProcData_Detect]
GO
/****** Object:  ForeignKey [FK_ProfileDetectResult_Detect]    Script Date: 06/16/2015 14:50:42 ******/
ALTER TABLE [dbo].[ProfileDetectResult]  WITH CHECK ADD  CONSTRAINT [FK_ProfileDetectResult_Detect] FOREIGN KEY([testDateTime])
REFERENCES [dbo].[Detect] ([testDateTime])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ProfileDetectResult] CHECK CONSTRAINT [FK_ProfileDetectResult_Detect]
GO
/****** Object:  ForeignKey [FK_ProfileDetectResult_real_Detect]    Script Date: 06/16/2015 14:50:42 ******/
ALTER TABLE [dbo].[ProfileDetectResult_real]  WITH CHECK ADD  CONSTRAINT [FK_ProfileDetectResult_real_Detect] FOREIGN KEY([testDateTime])
REFERENCES [dbo].[Detect] ([testDateTime])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ProfileDetectResult_real] CHECK CONSTRAINT [FK_ProfileDetectResult_real_Detect]
GO
/****** Object:  ForeignKey [FK_ScratchDetectResult_Detect]    Script Date: 06/16/2015 14:50:42 ******/
ALTER TABLE [dbo].[ScratchDetectResult]  WITH CHECK ADD  CONSTRAINT [FK_ScratchDetectResult_Detect] FOREIGN KEY([testDateTime])
REFERENCES [dbo].[Detect] ([testDateTime])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ScratchDetectResult] CHECK CONSTRAINT [FK_ScratchDetectResult_Detect]
GO
/****** Object:  ForeignKey [FK_Sequ_Detect]    Script Date: 06/16/2015 14:50:42 ******/
ALTER TABLE [dbo].[Sequ]  WITH CHECK ADD  CONSTRAINT [FK_Sequ_Detect] FOREIGN KEY([testDateTime])
REFERENCES [dbo].[Detect] ([testDateTime])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Sequ] CHECK CONSTRAINT [FK_Sequ_Detect]
GO
/****** Object:  ForeignKey [FK_VideoScratchDetectResult_Detect]    Script Date: 06/16/2015 14:50:42 ******/
ALTER TABLE [dbo].[VideoScratchDetectResult]  WITH CHECK ADD  CONSTRAINT [FK_VideoScratchDetectResult_Detect] FOREIGN KEY([testDateTime])
REFERENCES [dbo].[Detect] ([testDateTime])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[VideoScratchDetectResult] CHECK CONSTRAINT [FK_VideoScratchDetectResult_Detect]
GO
/****** Object:  ForeignKey [FK_WhmsTime_Detect]    Script Date: 06/16/2015 14:50:42 ******/
ALTER TABLE [dbo].[WhmsTime]  WITH CHECK ADD  CONSTRAINT [FK_WhmsTime_Detect] FOREIGN KEY([tychoTime])
REFERENCES [dbo].[Detect] ([testDateTime])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[WhmsTime] CHECK CONSTRAINT [FK_WhmsTime_Detect]
GO
