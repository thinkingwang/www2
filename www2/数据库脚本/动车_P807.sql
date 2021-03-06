USE [BaseWhprP807]
GO
/****** Object:  Table [dbo].[train]    Script Date: 06/16/2015 15:31:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[train](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[datetime_start] [datetime] NOT NULL,
	[datetime_stop] [datetime] NOT NULL,
	[WWPMSStationId] [varchar](10) NULL,
	[type] [varchar](20) NULL,
	[number] [varchar](20) NULL,
	[direction] [smallint] NOT NULL,
	[customer_direction] [smallint] NULL,
	[TrainUserDef1] [varchar](20) NULL,
	[TrainUserDef2] [varchar](20) NULL,
	[TrainUserDef3] [varchar](20) NULL,
	[speed] [float] NULL,
	[cars_num] [int] NOT NULL,
	[bogies_num] [int] NOT NULL,
	[axles_num] [int] NOT NULL,
 CONSTRAINT [PK_train] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[WheelType]    Script Date: 06/16/2015 15:31:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WheelType](
	[id_wheel_type] [int] IDENTITY(1,1) NOT NULL,
	[wheel_type] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_WheelTypeThresholds] PRIMARY KEY CLUSTERED 
(
	[id_wheel_type] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[WheelThresholds]    Script Date: 06/16/2015 15:31:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WheelThresholds](
	[id_thresholds] [int] IDENTITY(1,1) NOT NULL,
	[id_wheel_type] [int] NOT NULL,
	[active] [int] NOT NULL,
	[date_time] [datetime] NOT NULL,
	[Sh_warning_min] [real] NOT NULL,
	[Sh_warning_max] [real] NOT NULL,
	[Sh_alarm_min] [real] NOT NULL,
	[Sh_alarm_max] [real] NOT NULL,
	[Sd_warning_min] [real] NOT NULL,
	[Sd_warning_max] [real] NOT NULL,
	[Sd_alarm_min] [real] NOT NULL,
	[Sd_alarm_max] [real] NOT NULL,
	[Fa_warning_min] [real] NOT NULL,
	[Fa_warning_max] [real] NOT NULL,
	[Fa_alarm_min] [real] NOT NULL,
	[Fa_alarm_max] [real] NOT NULL,
	[D_warning_min] [real] NOT NULL,
	[D_warning_max] [real] NOT NULL,
	[D_alarm_min] [real] NOT NULL,
	[D_alarm_max] [real] NOT NULL,
	[L_warning_min] [real] NOT NULL,
	[L_warning_max] [real] NOT NULL,
	[L_alarm_min] [real] NOT NULL,
	[L_alarm_max] [real] NOT NULL,
	[Qr_warning_min] [real] NOT NULL,
	[Qr_warning_max] [real] NOT NULL,
	[Qr_alarm_min] [real] NOT NULL,
	[Qr_alarm_max] [real] NOT NULL,
	[Sc_warning_min] [real] NOT NULL,
	[Sc_warning_max] [real] NOT NULL,
	[Sc_alarm_min] [real] NOT NULL,
	[Sc_alarm_max] [real] NOT NULL,
	[Ht_warning_min] [real] NOT NULL,
	[Ht_warning_max] [real] NOT NULL,
	[Ht_alarm_min] [real] NOT NULL,
	[Ht_alarm_max] [real] NOT NULL,
	[Tt_warning_min] [real] NOT NULL,
	[Tt_warning_max] [real] NOT NULL,
	[Tt_alarm_min] [real] NOT NULL,
	[Tt_alarm_max] [real] NOT NULL,
	[G_warning_min] [real] NOT NULL,
	[G_warning_max] [real] NOT NULL,
	[G_alarm_min] [real] NOT NULL,
	[G_alarm_max] [real] NOT NULL,
	[O_warning_min] [real] NOT NULL,
	[O_warning_max] [real] NOT NULL,
	[O_alarm_min] [real] NOT NULL,
	[O_alarm_max] [real] NOT NULL,
	[Dd_warning_min] [real] NOT NULL,
	[Dd_warning_max] [real] NOT NULL,
	[Dd_alarm_min] [real] NOT NULL,
	[Dd_alarm_max] [real] NOT NULL,
	[Ei_warning_min] [real] NOT NULL,
	[Ei_warning_max] [real] NOT NULL,
	[Ei_alarm_min] [real] NOT NULL,
	[Ei_alarm_max] [real] NOT NULL,
	[Ea_warning_min] [real] NOT NULL,
	[Ea_warning_max] [real] NOT NULL,
	[Ea_alarm_min] [real] NOT NULL,
	[Ea_alarm_max] [real] NOT NULL,
	[Ra_warning_min] [real] NOT NULL,
	[Ra_warning_max] [real] NOT NULL,
	[Ra_alarm_min] [real] NOT NULL,
	[Ra_alarm_max] [real] NOT NULL,
	[La_warning_min] [real] NOT NULL,
	[La_warning_max] [real] NOT NULL,
	[La_alarm_min] [real] NOT NULL,
	[La_alarm_max] [real] NOT NULL,
	[Shd_warning_min] [real] NULL,
	[Shd_warning_max] [real] NULL,
	[Shd_alarm_min] [real] NULL,
	[Shd_alarm_max] [real] NULL,
	[Bdd_warning_min] [real] NULL,
	[Bdd_warning_max] [real] NULL,
	[Bdd_alarm_min] [real] NULL,
	[Bdd_alarm_max] [real] NULL,
	[Cdd_warning_min] [real] NULL,
	[Cdd_warning_max] [real] NULL,
	[Cdd_alarm_min] [real] NULL,
	[Cdd_alarm_max] [real] NULL,
	[FW1_warning_min] [real] NOT NULL,
	[FW1_warning_max] [real] NOT NULL,
	[FW1_alarm_min] [real] NOT NULL,
	[FW1_alarm_max] [real] NOT NULL,
	[FW2_warning_min] [real] NOT NULL,
	[FW2_warning_max] [real] NOT NULL,
	[FW2_alarm_min] [real] NOT NULL,
	[FW2_alarm_max] [real] NOT NULL,
	[FW3_warning_min] [real] NOT NULL,
	[FW3_warning_max] [real] NOT NULL,
	[FW3_alarm_min] [real] NOT NULL,
	[FW3_alarm_max] [real] NOT NULL,
	[FW4_warning_min] [real] NOT NULL,
	[FW4_warning_max] [real] NOT NULL,
	[FW4_alarm_min] [real] NOT NULL,
	[FW4_alarm_max] [real] NOT NULL,
	[QR1_warning_min] [real] NOT NULL,
	[QR1_warning_max] [real] NOT NULL,
	[QR1_alarm_min] [real] NOT NULL,
	[QR1_alarm_max] [real] NOT NULL,
	[QR2_warning_min] [real] NOT NULL,
	[QR2_warning_max] [real] NOT NULL,
	[QR2_alarm_min] [real] NOT NULL,
	[QR2_alarm_max] [real] NOT NULL,
 CONSTRAINT [PK_MeasureThresholds] PRIMARY KEY CLUSTERED 
(
	[id_thresholds] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[wheels]    Script Date: 06/16/2015 15:31:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[wheels](
	[train_id] [int] NOT NULL,
	[car_type] [varchar](20) NULL,
	[car_pos_on_train] [int] NULL,
	[car_order] [int] NULL,
	[car_number] [varchar](21) NULL,
	[CarUserDef1] [varchar](21) NULL,
	[bogie_id] [varchar](21) NULL,
	[bogie_pos_on_car] [int] NULL,
	[bogie_cust_pos_on_car] [int] NULL,
	[bogie_abs_pos_on_train] [int] NULL,
	[bogie_cust_abs_pos_on_train] [int] NULL,
	[bogie_orientation] [int] NULL,
	[BogieUserDef1] [varchar](21) NULL,
	[axle_id] [varchar](21) NULL,
	[axle_wpms_sequence] [int] NULL,
	[axle_pos_on_bogie] [int] NULL,
	[axle_cust_pos_on_bogie] [int] NULL,
	[axle_pos_car_train_dir] [int] NULL,
	[axle_cust_pos_on_car_train_dir] [int] NULL,
	[axle_abs_pos_on_train_dir] [int] NOT NULL,
	[axle_cust_abs_pos_on_train_dir] [int] NULL,
	[AxleUserDef1] [varchar](21) NULL,
	[wheel_id] [varchar](21) NULL,
	[wheel_side] [varchar](20) NOT NULL,
	[wheel_cust_side] [varchar](20) NULL,
	[wheel_mileage] [int] NULL,
	[WheelUserDef1] [varchar](21) NULL,
	[flange_height] [float] NULL,
	[flange_width] [float] NULL,
	[flange_angle] [float] NULL,
	[diameter] [float] NULL,
	[wheel_width] [float] NULL,
	[flange_gradient] [float] NULL,
	[rim_thickness] [float] NULL,
	[hollow_tread] [float] NULL,
	[tread_taper] [float] NULL,
	[gap] [float] NULL,
	[ovalization] [float] NULL,
	[flat] [float] NULL,
	[wear_profile] [varchar](50) NULL,
	[diameters_difference] [float] NULL,
	[back_to_back_gauge] [float] NULL,
	[external_gauge] [float] NULL,
	[right_external_gauge] [float] NULL,
	[left_external_gauge] [float] NULL,
	[flange_width_difference] [float] NULL,
	[bogie_diameter_difference] [float] NULL,
	[car_diameter_difference] [float] NULL,
	[axle_speed] [float] NULL,
	[wheel_warning_low_bit_mask] [int] NULL,
	[wheel_warning_bit_mask] [int] NULL,
	[wheel_alarm_low_bit_mask] [int] NULL,
	[wheel_alarm_bit_mask] [int] NULL,
	[axle_warning_low_bit_mask] [int] NULL,
	[axle_warning_bit_mask] [int] NULL,
	[axle_alarm_low_bit_mask] [int] NULL,
	[axle_alarm_bit_mask] [int] NULL,
	[threshold_id] [int] NOT NULL,
	[flange_width1] [float] NULL,
	[flange_width2] [float] NULL,
	[flange_width3] [float] NULL,
	[flange_width4] [float] NULL,
	[qr1] [float] NULL,
	[qr2] [float] NULL,
 CONSTRAINT [PK_wheels] PRIMARY KEY CLUSTERED 
(
	[train_id] ASC,
	[axle_abs_pos_on_train_dir] ASC,
	[wheel_side] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  StoredProcedure [dbo].[uphistory]    Script Date: 06/16/2015 15:31:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[uphistory] 
@whprTime datetime,
@testTime datetime
--WITH ENCRYPTION
AS
declare @id int
declare @axle_wpms_sequence int
declare @wheel_side varchar(21)
declare @axleNo tinyint
declare @wheelNo tinyint
declare @diameter float
declare @flange_height float
declare @flange_width float
declare @tread float
declare @qr float
declare @rim_thickness float
declare @rim_thickness2 float
declare @back_to_back_gauge float
declare @xmlFile varchar(50)
declare @cursor_test cursor 
declare @pos int
declare @carPos int
declare @carNo varchar(20)
declare @dir int
declare @AxleNum int
declare @bzh varchar(50)
declare @isCrh int
declare @trainType varchar(20)
declare @dia_max float
declare @dia_min float
declare @lygd_std float
--未测出时的值
declare @NoData float
--数据微调值 左轮
declare @ad_Lj_L float
declare @ad_LyHd_L float
declare @ad_LyGd_L float
declare @ad_LwHd_L float
declare @ad_LwHd2_L float
declare @ad_QR_L float
declare @ad_Ncj_L float
--数据微调值 右轮
declare @ad_Lj_R float
declare @ad_LyHd_R float
declare @ad_LyGd_R float
declare @ad_LwHd_R float
declare @ad_LwHd2_R float
declare @ad_QR_R float
declare @ad_Ncj_R float
--是否是5型车
declare @isCrh5 int
BEGIN
SET NOCOUNT ON;
DECLARE @whmsTime as datetime;
DECLARE @tychoTime as datetime;

set @whmsTime = convert(datetime,@whprTime,121);
set @tychoTime = convert(datetime,@testTime,121);

	begin
		set @NoData = -1000;
		set @dia_max=0;
		select @AxleNum = axleNum, @dir=engineDirection, @bzh=engNum  
		from [tycho_kc].[dbo].detect 
		where testdatetime=@tychoTime
		
		if (CHARINDEX('-',@bzh) > 0)
			set @trainType= left(@bzh,CHARINDEX('-',@bzh)-1)
		else
			set @trainType= 'default' --默认车型
			
		--轮径极限，超过就认为无效		
		select @dia_max = standard+5, @dia_min=low_level1-5 
		from [tycho_kc].[dbo].[thresholds] 
		where trainType=@trainType and name='WX_LJ'
		
		--标准轮缘
		select @lygd_std = standard 
		from [tycho_kc].[dbo].[thresholds] 
		where trainType=@trainType and name='WX_LYGD'
		
		if (SUBSTRING(@bzh,1,3)!='CRH') 
			begin
				set @isCrh = 0
			end
		else
			begin
				set @isCrh = 1
			end
		--是否是5型车
		if (SUBSTRING(@bzh,1,4)!='CRH5') 
			begin
				set @isCrh5 = 0
			end
		else
			begin
				set @isCrh5 = 1
			end			
		--清空
		delete from [tycho_kc].[dbo].[ProfileDetectResult] where testDateTime=@tychoTime
		if (@isCrh>0)
			begin
				delete from [tycho_kc].[dbo].[ProfileDetectResult_real] where testDateTime=@tychoTime
			end
		
		--原始数据
		select @id = id from train where datetime_start=@whmsTime
		
		if (@isCrh5>0)
			begin
				set @cursor_test = cursor for 
				select axle_wpms_sequence,wheel_side,diameter,hollow_tread,flange_width1,wheel_width,rim_thickness,back_to_back_gauge,wear_profile,flange_height,qr2 
				from wheels 
				where train_id =@id 
				order by axle_wpms_sequence, wheel_side
			end
		else
			begin
				set @cursor_test = cursor for 
				select axle_wpms_sequence,wheel_side,diameter,hollow_tread,flange_width,wheel_width,rim_thickness,back_to_back_gauge,wear_profile,flange_height,flange_gradient 
				from wheels 
				where train_id =@id 
				order by axle_wpms_sequence, wheel_side
			end		
		
		
		
		open @cursor_test 
		fetch next from @cursor_test 
		into @axle_wpms_sequence,@wheel_side,@diameter,@tread,@flange_width,@rim_thickness,@rim_thickness2,@back_to_back_gauge,@xmlFile,@flange_height,@qr
		
		--取微调值
		select  @ad_Lj_L = Lj,  @ad_LyHd_L = LyHd,  @ad_LyGd_L = LyGd,  @ad_LwHd_L = LwHd, @ad_LwHd2_L = LwHd2, @ad_QR_L = QR, @ad_Ncj_L = Ncj
		from [tycho_kc].[dbo].[ProfileAdjust]
		where position = 0
		
		select  @ad_Lj_R = Lj,  @ad_LyHd_R = LyHd,  @ad_LyGd_R = LyGd,  @ad_LwHd_R = LwHd, @ad_LwHd2_R = LwHd2, @ad_QR_R = QR, @ad_Ncj_R = Ncj
		from [tycho_kc].[dbo].[ProfileAdjust]
		where position = 1
		
		while(@@fetch_status=0)
		begin
		    set @axleNo = @axle_wpms_sequence-1
		    --左轮
			if (@wheel_side = 'LEFT')
				begin
					set @wheelNo = 0
					--微调
					if (@diameter!= @NoData)
						set @diameter = @diameter + @ad_Lj_L
					if 	(@flange_width != @NoData)
						set @flange_width = @flange_width + @ad_LyHd_L
					if  (@rim_thickness != @NoData)
						set @rim_thickness = @rim_thickness + @ad_LwHd_L
					if  (@rim_thickness2 != @NoData)
						set @rim_thickness2 = @rim_thickness2 + @ad_LwHd2_L
					if  (@flange_height != @NoData)
						set @flange_height = @flange_height + @ad_LyGd_L
					if  (@qr != @NoData)
						set @qr = @qr + @ad_QR_L
				end
			--右轮
			else
				begin
					set @wheelNo = 1
					--微调
					if (@diameter!=@NoData)
						set @diameter = @diameter + @ad_Lj_R
					if 	(@flange_width != @NoData)
						set @flange_width = @flange_width + @ad_LyHd_R
					if  (@rim_thickness != @NoData)
						set @rim_thickness = @rim_thickness + @ad_LwHd_R
					if  (@rim_thickness2 != @NoData)
						set @rim_thickness2 = @rim_thickness2 + @ad_LwHd2_R
					if  (@flange_height != @NoData)
						set @flange_height = @flange_height + @ad_LyGd_R
					if  (@qr != @NoData)
						set @qr = @qr + @ad_QR_R
				end
			--内距微调	
			if @back_to_back_gauge != @NoData
				set @back_to_back_gauge = @back_to_back_gauge + @ad_Ncj_R			
			
			--计算踏面磨耗	
			if (@flange_height != @NoData)
				set @tread = @flange_height - @lygd_std
			else
			    set @tread = @NoData

            if (@isCrh>0)
            begin
				--轮径超过极限，认为无效
				if @dia_max > 0
				begin
					if @diameter>=@dia_max or @diameter<@dia_min
						set @diameter = @NoData
				end
			end

			insert into [tycho_kc].[dbo].[ProfileDetectResult]  (testDateTime, axleNo, wheelNo, Lj, TmMh, LyHd, LwHd, LwHd2, Ncj, xmlFile, LyGd, QR) 
			values(@tychoTime,@axleNo,@wheelNo,@diameter,@tread,@flange_width,@rim_thickness,@rim_thickness2,@back_to_back_gauge,@xmlFile,@flange_height,@qr)
			
			--原始实测数据表
			if (@isCrh>0)
			begin
				set @carPos = @axleNo/4
				set @pos = [tycho_kc].[dbo].wheelPos(@bzh,@axleNo, @wheelNo, @dir)
				select @carNo=carNo from [tycho_kc].[dbo].CarList where testDateTime=@tychoTime and posNo=@carPos
				insert into [tycho_kc].[dbo].[ProfileDetectResult_real]  (testDateTime, axleNo, wheelNo, Lj, TmMh, LyHd, LwHd, LwHd2,Ncj, xmlFile, LyGd, QR, pos, carPos, carNo, Lj_user) 
				values(@tychoTime,@axleNo,@wheelNo,@diameter,@tread,@flange_width,@rim_thickness,@rim_thickness2,@back_to_back_gauge,@xmlFile,@flange_height,@qr,@pos,@carPos,@carNo,@diameter)
			end
			
			fetch next from @cursor_test 
			into @axle_wpms_sequence,@wheel_side,@diameter,@tread,@flange_width,@rim_thickness,@rim_thickness2,@back_to_back_gauge,@xmlFile,@flange_height,@qr
		end

		close @cursor_test
		deallocate @cursor_test
    end
    
	exec [tycho_kc].[dbo].profile_LjCha @tychoTime
	exec [tycho_kc].[dbo].profile @tychoTime
	if (@isCrh >0)
	begin

		declare @out int
		--补缺数
		exec [tycho_kc].[dbo].proc_LJ_BatchDatafill @testTime, 'Lj', @NoData, @out output
		exec [tycho_kc].[dbo].proc_LJ_BatchDatafill @testTime, 'TmMh', @NoData, @out output
		exec [tycho_kc].[dbo].proc_LJ_BatchDatafill @testTime, 'LyHd', @NoData, @out output
		exec [tycho_kc].[dbo].proc_LJ_BatchDatafill @testTime, 'LwHd', @NoData, @out output
		exec [tycho_kc].[dbo].proc_LJ_BatchDatafill @testTime, 'QR', @NoData, @out output
		exec [tycho_kc].[dbo].proc_LJ_BatchDatafill @testTime, 'ncj', @NoData, @out output
		--重算轮径差及报警
		exec [tycho_kc].[dbo].profile_LjCha @tychoTime
		exec [tycho_kc].[dbo].profile @tychoTime
			
		--均值处理
		exec [tycho_kc].[dbo].Profile_patch0 @tychoTime
		--历史关联
		exec [tycho_kc].[dbo].Profile_patch @tychoTime
				
		--防数据跳变		
		exec [tycho_kc].[dbo].proc_JumpValuesChange 'dc', @testTime, 4, -4,  @out output
		--精度处理
		exec [tycho_kc].[dbo].proc_PrecisionAdjustment @testTime, @out output		
		--重算轮径差及报警
		exec [tycho_kc].[dbo].profile_LjCha @testTime
		exec [tycho_kc].[dbo].profile @testTime
		
		--同轴差调整	
		exec [tycho_kc].[dbo].proc_TZC_DataAdjustment @tychoTime, @out output
		
		exec [tycho_kc].[dbo].proc_TZC_DataAdjustment2 @tychoTime, @out output
		
		exec [tycho_kc].[dbo].profile @testTime		

	end
END
GO
/****** Object:  StoredProcedure [dbo].[uphistory2]    Script Date: 06/16/2015 15:31:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[uphistory2] 
@tychoTime varchar(25)
--WITH ENCRYPTION
AS

BEGIN
	SET NOCOUNT ON;
	
DECLARE @whmsTime as datetime;
--DECLARE @tychoTime as datetime;

--set @whmsTime = convert(datetime,@whprTime,121);
--print @testTime
--set @tychoTime = convert(datetime,@testTime,121);
--print @tychoTime
select @whmsTime = whmstime from [tycho_kc].[dbo].[whmsTime] where tychoTime = @tychoTime
exec uphistory @whmsTime, @tychoTime

END
GO
/****** Object:  StoredProcedure [dbo].[upAll2]    Script Date: 06/16/2015 15:31:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create PROCEDURE [dbo].[upAll2] 
@startTime datetime,
@endTime datetime
--WITH ENCRYPTION
AS

declare @cursor_test cursor 

BEGIN
	SET NOCOUNT ON;
DECLARE @whmsTime as datetime;
DECLARE @tychoTime as datetime;
DECLARE @t1 as varchar(25);
DECLARE @w1 as varchar(25);

	begin
		set @cursor_test = cursor for select tychoTime,whmsTime from [tycho_kc].[dbo].[WhmsTime] where tychoTime between @startTime and @endTime order by tychoTime
		open @cursor_test 
		fetch next from @cursor_test into @tychoTime,@whmsTime
		while(@@fetch_status=0)
		begin
			set @t1 = CONVERT(CHAR(19),@tychoTime,120)
			set @w1 = CONVERT(CHAR(19),@whmsTime,120)
			print @t1
			exec uphistory @w1,@t1
			fetch next from @cursor_test into @tychoTime,@whmsTime
		end

		close @cursor_test
		deallocate @cursor_test
    end
END
GO
/****** Object:  StoredProcedure [dbo].[upAll]    Script Date: 06/16/2015 15:31:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[upAll] 
--WITH ENCRYPTION
AS

declare @cursor_test cursor 

BEGIN
	SET NOCOUNT ON;
DECLARE @whmsTime as datetime;
DECLARE @tychoTime as datetime;
DECLARE @t1 as varchar(25);
DECLARE @w1 as varchar(25);

	begin
		set @cursor_test = cursor for select tychoTime,whmsTime from [tycho_kc].[dbo].[WhmsTime]
		open @cursor_test 
		fetch next from @cursor_test into @tychoTime,@whmsTime
		while(@@fetch_status=0)
		begin
			set @t1 = CONVERT(CHAR(19),@tychoTime,120)
			set @w1 = CONVERT(CHAR(19),@whmsTime,120)
			print @t1
			exec uphistory @w1,@t1
			fetch next from @cursor_test into @tychoTime,@whmsTime
		end

		close @cursor_test
		deallocate @cursor_test
    end
END
GO
/****** Object:  StoredProcedure [dbo].[tycho]    Script Date: 06/16/2015 15:31:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[tycho] 
@whprTime varchar(25)
--WITH ENCRYPTION
AS
declare @tychoTime datetime
declare @now datetime
DECLARE @whmsTime  datetime;
BEGIN
	SET NOCOUNT ON;	
	set @whmsTime = convert(datetime,@whprTime,121);
	insert into [tycho_kc].[dbo].log values(Getdate(),'p807','',0,@whmsTime);
	select @tychoTime=testdatetime from [tycho_kc].[dbo].[detect] where testdatetime between dateadd(minute,-1,@whmsTime) and dateadd(minute,1,@whmsTime)
	--set @tychoTime='2013-04-16 08:55:40'
	delete from [tycho_kc].[dbo].[WhmsTime] where tychoTime=@tychoTime
	insert into [tycho_kc].[dbo].[WhmsTime] values(@tychoTime, @whmsTime)
    if (@@rowcount=1)
       exec [dbo].uphistory @whmsTime, @tychoTime
    --set @now = (select getdate())
    --insert into [tycho_kc].[dbo].[ProcData]([CommitTime],[testDateTime],[NeedProc]) values(@now, @tychoTime,1)
END
GO
/****** Object:  Default [DF__WheelThre__FW1_w__1FCDBCEB]    Script Date: 06/16/2015 15:31:50 ******/
ALTER TABLE [dbo].[WheelThresholds] ADD  DEFAULT ((-1000.0)) FOR [FW1_warning_min]
GO
/****** Object:  Default [DF__WheelThre__FW1_w__20C1E124]    Script Date: 06/16/2015 15:31:50 ******/
ALTER TABLE [dbo].[WheelThresholds] ADD  DEFAULT ((-1000.0)) FOR [FW1_warning_max]
GO
/****** Object:  Default [DF__WheelThre__FW1_a__21B6055D]    Script Date: 06/16/2015 15:31:50 ******/
ALTER TABLE [dbo].[WheelThresholds] ADD  DEFAULT ((-1000.0)) FOR [FW1_alarm_min]
GO
/****** Object:  Default [DF__WheelThre__FW1_a__22AA2996]    Script Date: 06/16/2015 15:31:50 ******/
ALTER TABLE [dbo].[WheelThresholds] ADD  DEFAULT ((-1000.0)) FOR [FW1_alarm_max]
GO
/****** Object:  Default [DF__WheelThre__FW2_w__239E4DCF]    Script Date: 06/16/2015 15:31:50 ******/
ALTER TABLE [dbo].[WheelThresholds] ADD  DEFAULT ((-1000.0)) FOR [FW2_warning_min]
GO
/****** Object:  Default [DF__WheelThre__FW2_w__24927208]    Script Date: 06/16/2015 15:31:50 ******/
ALTER TABLE [dbo].[WheelThresholds] ADD  DEFAULT ((-1000.0)) FOR [FW2_warning_max]
GO
/****** Object:  Default [DF__WheelThre__FW2_a__25869641]    Script Date: 06/16/2015 15:31:50 ******/
ALTER TABLE [dbo].[WheelThresholds] ADD  DEFAULT ((-1000.0)) FOR [FW2_alarm_min]
GO
/****** Object:  Default [DF__WheelThre__FW2_a__267ABA7A]    Script Date: 06/16/2015 15:31:50 ******/
ALTER TABLE [dbo].[WheelThresholds] ADD  DEFAULT ((-1000.0)) FOR [FW2_alarm_max]
GO
/****** Object:  Default [DF__WheelThre__FW3_w__276EDEB3]    Script Date: 06/16/2015 15:31:50 ******/
ALTER TABLE [dbo].[WheelThresholds] ADD  DEFAULT ((-1000.0)) FOR [FW3_warning_min]
GO
/****** Object:  Default [DF__WheelThre__FW3_w__286302EC]    Script Date: 06/16/2015 15:31:50 ******/
ALTER TABLE [dbo].[WheelThresholds] ADD  DEFAULT ((-1000.0)) FOR [FW3_warning_max]
GO
/****** Object:  Default [DF__WheelThre__FW3_a__29572725]    Script Date: 06/16/2015 15:31:50 ******/
ALTER TABLE [dbo].[WheelThresholds] ADD  DEFAULT ((-1000.0)) FOR [FW3_alarm_min]
GO
/****** Object:  Default [DF__WheelThre__FW3_a__2A4B4B5E]    Script Date: 06/16/2015 15:31:50 ******/
ALTER TABLE [dbo].[WheelThresholds] ADD  DEFAULT ((-1000.0)) FOR [FW3_alarm_max]
GO
/****** Object:  Default [DF__WheelThre__FW4_w__2B3F6F97]    Script Date: 06/16/2015 15:31:50 ******/
ALTER TABLE [dbo].[WheelThresholds] ADD  DEFAULT ((-1000.0)) FOR [FW4_warning_min]
GO
/****** Object:  Default [DF__WheelThre__FW4_w__2C3393D0]    Script Date: 06/16/2015 15:31:50 ******/
ALTER TABLE [dbo].[WheelThresholds] ADD  DEFAULT ((-1000.0)) FOR [FW4_warning_max]
GO
/****** Object:  Default [DF__WheelThre__FW4_a__2D27B809]    Script Date: 06/16/2015 15:31:50 ******/
ALTER TABLE [dbo].[WheelThresholds] ADD  DEFAULT ((-1000.0)) FOR [FW4_alarm_min]
GO
/****** Object:  Default [DF__WheelThre__FW4_a__2E1BDC42]    Script Date: 06/16/2015 15:31:50 ******/
ALTER TABLE [dbo].[WheelThresholds] ADD  DEFAULT ((-1000.0)) FOR [FW4_alarm_max]
GO
/****** Object:  Default [DF__WheelThre__QR1_w__2F10007B]    Script Date: 06/16/2015 15:31:50 ******/
ALTER TABLE [dbo].[WheelThresholds] ADD  DEFAULT ((-1000.0)) FOR [QR1_warning_min]
GO
/****** Object:  Default [DF__WheelThre__QR1_w__300424B4]    Script Date: 06/16/2015 15:31:50 ******/
ALTER TABLE [dbo].[WheelThresholds] ADD  DEFAULT ((-1000.0)) FOR [QR1_warning_max]
GO
/****** Object:  Default [DF__WheelThre__QR1_a__30F848ED]    Script Date: 06/16/2015 15:31:50 ******/
ALTER TABLE [dbo].[WheelThresholds] ADD  DEFAULT ((-1000.0)) FOR [QR1_alarm_min]
GO
/****** Object:  Default [DF__WheelThre__QR1_a__31EC6D26]    Script Date: 06/16/2015 15:31:50 ******/
ALTER TABLE [dbo].[WheelThresholds] ADD  DEFAULT ((-1000.0)) FOR [QR1_alarm_max]
GO
/****** Object:  Default [DF__WheelThre__QR2_w__32E0915F]    Script Date: 06/16/2015 15:31:50 ******/
ALTER TABLE [dbo].[WheelThresholds] ADD  DEFAULT ((-1000.0)) FOR [QR2_warning_min]
GO
/****** Object:  Default [DF__WheelThre__QR2_w__33D4B598]    Script Date: 06/16/2015 15:31:50 ******/
ALTER TABLE [dbo].[WheelThresholds] ADD  DEFAULT ((-1000.0)) FOR [QR2_warning_max]
GO
/****** Object:  Default [DF__WheelThre__QR2_a__34C8D9D1]    Script Date: 06/16/2015 15:31:50 ******/
ALTER TABLE [dbo].[WheelThresholds] ADD  DEFAULT ((-1000.0)) FOR [QR2_alarm_min]
GO
/****** Object:  Default [DF__WheelThre__QR2_a__35BCFE0A]    Script Date: 06/16/2015 15:31:50 ******/
ALTER TABLE [dbo].[WheelThresholds] ADD  DEFAULT ((-1000.0)) FOR [QR2_alarm_max]
GO
/****** Object:  ForeignKey [FK_wheels_train]    Script Date: 06/16/2015 15:31:50 ******/
ALTER TABLE [dbo].[wheels]  WITH CHECK ADD  CONSTRAINT [FK_wheels_train] FOREIGN KEY([train_id])
REFERENCES [dbo].[train] ([id])
GO
ALTER TABLE [dbo].[wheels] CHECK CONSTRAINT [FK_wheels_train]
GO
/****** Object:  ForeignKey [FK_wheels_WheelThresholds]    Script Date: 06/16/2015 15:31:50 ******/
ALTER TABLE [dbo].[wheels]  WITH NOCHECK ADD  CONSTRAINT [FK_wheels_WheelThresholds] FOREIGN KEY([threshold_id])
REFERENCES [dbo].[WheelThresholds] ([id_thresholds])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[wheels] CHECK CONSTRAINT [FK_wheels_WheelThresholds]
GO
/****** Object:  ForeignKey [FK_WheelThresholds_WheelType]    Script Date: 06/16/2015 15:31:50 ******/
ALTER TABLE [dbo].[WheelThresholds]  WITH NOCHECK ADD  CONSTRAINT [FK_WheelThresholds_WheelType] FOREIGN KEY([id_wheel_type])
REFERENCES [dbo].[WheelType] ([id_wheel_type])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[WheelThresholds] NOCHECK CONSTRAINT [FK_WheelThresholds_WheelType]
GO
