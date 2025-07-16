print('centrl')
local var_0=game:GetService("InsertService");
local TweenService = game:GetService("TweenService");
local var_1=game:GetService("HttpService");
local RunService = game:GetService("RunService");
local UserInputService = game:GetService("UserInputService");
local var_2=game:GetService("Players"):GetPlayers();
local var_3=game:GetService("TextService");
local var_4=game:GetService("Players");
local var_3=game:GetService("TextService");
local var_5=game:GetService("CoreGui");
local var_6=game:GetObjects("rbxassetid://110108698354493")[1 + 0 ];
local var_7=game:GetObjects("rbxassetid://91148934400630")[1 -0 ];
var_7.Enabled=false;
var_6.Enabled=false;
local var_8={theme={Accent=Color3.fromRGB(21 + 206 ,1916 -1661 ,56 -14 ),Hitbox=Color3.fromRGB(227,238 + 17 ,898 -856 ),Glow=Color3.fromRGB(0,0,0 -0 )},util={},Connections={},Flags={},Comms=Instance.new("BindableEvent")};
if  not var_8.Connections then
 var_8.Connections={};
end
 var_8.UpdateTheme=function(v53,v54) for v134,v135 in pairs(v54) do
 if (v53.theme[v134]~=nil) then
 local var_131=0 -0 ;
while true do
 if (var_131==0) then
 v53.theme[v134]=v135;
v53.Comms:Fire(v134,v135);
break;
end
 end
 end
 end
 end
;
var_8.util.GetSide=function(v55,v56) return (((v55-(305 -304))>(v56-1)) and "R") or "L" ;
end
;
var_8.util.removeplaceholder=function(v57,v58) v57[v58].Visible=false or (v57.Visible==false) ;
end
;
var_8.util.AddConnection=function(v60,v61) if ( not v60 or  not v61) then
 local var_89=0 + 0 ;
while true do
 if (var_89==(476 -476)) then
 error("Type, EventName, and Callback parameters are required for AddConnection.");
return;
end
 end
 end
 local var_18=v60:Connect(v61);
table.insert(var_8.Connections,{Connection=var_18});
local var_19=function() local var_49=0;
while true do
 if (var_49==(1001 -1001)) then
 var_18:Disconnect();
for v795,v796 in ipairs(var_8.Connections) do
 if (v796.Connection==var_18) then
 table.remove(var_8.Connections,v795);
break;
end
 end
 break;
end
 end
 end
;
return var_18,var_19;
end
;
var_8.util.MakeResizeable=function(v64,v65,v66,v67) local var_20,v69=nil,nil;
var_8.util.AddConnection(v64.InputBegan,function(v137) if (v137.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
 var_20=v4:GetMouseLocation();
v69=v65.AbsoluteSize;
end
 end
);
var_8.util.AddConnection(v4.InputChanged,function(v138) if (var_20 and (v138.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch)) then
 local var_132=0 + 0 ;
local var_133;
local var_134;
local var_135;
local var_136;
local var_137;
while true do
 if (var_132==(1127 -1125)) then
 var_137=math.max(v66.Y,var_135.Y);
v65:TweenSize(UDim2.fromOffset(var_136,var_137),Enum.EasingDirection.Out,Enum.EasingStyle.Quad,0.2 + 0 ,true);
break;
end
 if (var_132==(1613 -1613)) then
 var_133=v4:GetMouseLocation();
var_134=var_133-var_20 ;
var_132=1 + 0 ;
end
 if (var_132==1) then
 var_135=v69 + var_134 ;
var_136=math.max(v66.X,var_135.X);
var_132=2;
end
 end
 end
 end
);
var_8.util.AddConnection(v64.InputEnded,function(v139) if (v139.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
 var_20,v69=nil,nil;
end
 end
);
end
;
local var_9={};
var_8.util.registerLoadTween=function(v70,v71,v72,v73) table.insert(var_9,{object=v70,tweenInfo=v73,properties=v71,initialState=v72});
end
;
var_8.util.resetToInitialState=function() for v140,v141 in ipairs(var_9) do
 for v243,v244 in pairs(v141.initialState) do
 v141.object[v243]=v244;
end
 end
 end
;
var_8.util.replayLoadTweens=function() local var_21=1138 -1138 ;
while true do
 if ((267 -267)==var_21) then
 var_8.util.resetToInitialState();
for v624,v625 in ipairs(var_9) do
 local var_224=0;
local var_225;
while true do
 if (0==var_224) then
 var_225=v1:Create(v625.object,v625.tweenInfo,v625.properties);
var_225:Play();
break;
end
 end
 end
 break;
end
 end
 end
;
var_8.util.AddDrag=function(v75,v76,v77) pcall(function() local var_50=0 -0 ;
local var_51;
local var_52;
local var_53;
local var_54;
local var_55;
while true do
 if (var_50==4) then
 var_8.util.AddConnection(v4.InputChanged,function(v797) if ((v797==var_52) and var_51) then
 local var_324=1092 -1092 ;
local var_325;
while true do
 if (var_324==(1875 -1875)) then
 var_325=v797.Position-var_53 ;
v1:Create(v76,TweenInfo.new(var_55,Enum.EasingStyle.Quint,Enum.EasingDirection.Out),{Position=UDim2.new(var_54.X.Scale,var_54.X.Offset + var_325.X ,var_54.Y.Scale,var_54.Y.Offset + var_325.Y )}):Play();
break;
end
 end
 end
 end
);
break;
end
 if (var_50==1) then
 var_53=false;
var_54=false;
var_50=2 + 0 ;
end
 if (2==var_50) then
 v77=v77 or 0 ;
var_55=v77;
var_50=10 -7 ;
end
 if (var_50==(1018 -1018)) then
 var_51=false;
var_52=false;
var_50=2 -1 ;
end
 if (var_50==3) then
 var_8.util.AddConnection(v75.InputBegan,function(v798) if (v798.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
 local var_326=0 -0 ;
while true do
 if (var_326==1) then
 var_54=v76.Position;
v798.Changed:Connect(function() if (v798.UserInputState==Enum.UserInputState.End) then
 var_51=false;
end
 end
);
break;
end
 if (0==var_326) then
 var_51=true;
var_53=v798.Position;
var_326=2 -1 ;
end
 end
 end
 end
);
var_8.util.AddConnection(v75.InputChanged,function(v799) if (v799.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
 var_52=v799;
end
 end
);
var_50=1231 -1227 ;
end
 end
 end
);
end
;
var_8.util.PrintTable=function(v78,v79,v80) local var_22=611 -611 ;
local var_23;
while true do
 if (var_22==(1189 -1189)) then
 v80=v80 or (872 -872) ;
var_23=string.rep("  ",v80);
var_22=1;
end
 if (var_22==1) then
 for v628,v629 in pairs(v79) do
 if (type(v629)=="table") then
 print(var_23   .. tostring(v628)   .. " = {" );
var_8.util:PrintTable(v629,v80 + (948 -947) );
print(var_23   .. "}" );
else
 print(var_23   .. tostring(v628)   .. " = "   .. tostring(v629) );
end
 end
 break;
end
 end
 end
;
var_8.util.CompareColors=function(v83,v84) return (v83.R==v84.R) and (v83.G==v84.G) and (v83.B==v84.B) ;
end
;
var_8.util.ColorUnpack=function(v85) local var_24=0;
while true do
 if (var_24==0) then
 assert((type(v85)=="table") or (type(v85)=="string") ,"Invalid color format. Expected table (RGB) or string (HEX).");
if (type(v85)=="table") then
 local var_269=0 + 0 ;
while true do
 if (var_269==(1898 -1898)) then
 assert(v85.R and v85.G and v85.B ,"RGB table must contain 'R', 'G', and 'B' keys.");
return Color3.fromRGB(math.clamp(v85.R,440 -440 ,255),math.clamp(v85.G,0 -0 ,212 + 43 ),math.clamp(v85.B,0,526 -271 ));
end
 end
 elseif (type(v85)=="string") then
 local var_327=v85:match("^#?(%x%x%x%x%x%x)$");
assert(var_327,"Invalid HEX color format. Expected '#RRGGBB' or 'RRGGBB'.");
local var_328,v950,v951=tonumber(var_327:sub(1,5 -3 ),16),tonumber(var_327:sub(1208 -1205 ,8 -4 ),16),tonumber(var_327:sub(5,6),16);
return Color3.fromRGB(var_328,v950,v951);
end
 break;
end
 end
 end
;
var_8.util.ColorPack=function(v87) local var_25=0;
while true do
 if (var_25==0) then
 assert(typeof(v87)=="Color3" ,"PackColor expects a Color3 value.");
return {R=math.round(v87.R * 255 ),G=math.round(v87.G * 255 ),B=math.round(v87.B * 255 )};
end
 end
 end
;
local var_10={};
local var_11=1700 -1690 ;
local var_12=TweenInfo.new(0.5,Enum.EasingStyle.Quad,Enum.EasingDirection.Out);
function updatePositions() local var_26=0;
for v148,v149 in ipairs(var_10) do
 local var_56=UDim2.new(214 -214 ,0,683 -683 ,var_26);
v1:Create(v149,var_12,{Position=var_56}):Play();
var_26=var_26 + v149.Size.Y.Offset + var_11 ;
end
 end
 var_8.Notify=function(v90,v91) task.spawn(function() local var_57=0;
local var_58;
local var_59;
local var_60;
local var_61;
local var_62;
while true do
 if (var_57==(1467 -1463)) then
 var_58.DurationFrame.Duration.BackgroundColor3=var_8.theme.Accent;
if (v91.Type=="Warn") then
 var_58.DurationFrame.Duration.BackgroundColor3=Color3.fromRGB(697 -442 ,116 -29 ,855 -765 );
elseif (v91.Type=="Success") then
 var_58.DurationFrame.Duration.BackgroundColor3=Color3.fromRGB(113,817 -562 ,88);
end
 table.insert(var_10,var_58);
updatePositions();
var_57=16 -11 ;
end
 if (3==var_57) then
 var_58.Title.TextTransparency=1 -0 ;
var_58.Content.TextTransparency=1 + 0 ;
var_58.DurationFrame.BackgroundTransparency=237 -236 ;
var_58.DurationFrame.Duration.BackgroundTransparency=1;
var_57=4 + 0 ;
end
 if (var_57==0) then
 var_58=var_7.temp:Clone();
var_58.Visible=true;
var_58.Parent=var_7.renders.Notifcations;
var_58.Title.Text=v91.Title;
var_57=2 -1 ;
end
 if (var_57==2) then
 var_58.Size=UDim2.new(1, -10,0,math.max(var_59 + var_60 + 46 ,43 + 17 ));
var_58.Position=UDim2.new(0 + 0 ,0,0 -0 , -var_58.Size.Y.Offset);
var_58.UIScale.Scale=0.8;
var_58.BackgroundTransparency=1 + 0 ;
var_57=166 -163 ;
end
 if (var_57==7) then
 v1:Create(var_58.DurationFrame.Duration,TweenInfo.new(var_62,Enum.EasingStyle.Linear),{Size=UDim2.new(1 -0 ,0,766 -765 ,0 + 0 )}):Play();
task.delay(var_62,function() if (var_58 and var_58.Parent) then
 table.remove(var_10,table.find(var_10,var_58));
v1:Create(var_58,var_61,{BackgroundTransparency=2 -1 }):Play();
v1:Create(var_58.UIScale,var_61,{Scale=0.8 + 0 }):Play();
v1:Create(var_58.Title,var_61,{TextTransparency=850 -849 }):Play();
v1:Create(var_58.Content,var_61,{TextTransparency=1}):Play();
v1:Create(var_58.DurationFrame,var_61,{BackgroundTransparency=127 -126 }):Play();
v1:Create(var_58.DurationFrame.Duration,var_61,{BackgroundTransparency=1 -0 }):Play();
v1:Create(var_58,var_61,{Position=UDim2.new(0,0,1790 -1790 , -var_58.Size.Y.Offset)}):Play();
task.wait(0.4);
var_58:Destroy();
updatePositions();
end
 end
);
break;
end
 if (5==var_57) then
 var_61=TweenInfo.new(0.4,Enum.EasingStyle.Quint);
v1:Create(var_58,var_61,{BackgroundTransparency=0 -0 }):Play();
v1:Create(var_58.UIScale,var_61,{Scale=1}):Play();
v1:Create(var_58.Title,var_61,{TextTransparency=0 + 0 }):Play();
var_57=6;
end
 if (var_57==1) then
 var_58.Content.Text=v91.Content;
var_58.Content.TextWrapped=true;
var_59=var_58.Title.TextBounds.Y;
var_60=var_58.Content.TextBounds.Y;
var_57=2 -0 ;
end
 if (var_57==(945 -939)) then
 v1:Create(var_58.Content,var_61,{TextTransparency=0 -0 }):Play();
v1:Create(var_58.DurationFrame,var_61,{BackgroundTransparency=0 -0 }):Play();
v1:Create(var_58.DurationFrame.Duration,var_61,{BackgroundTransparency=0 + 0 }):Play();
var_62=v91.Duration or 5 ;
var_57=10 -3 ;
end
 end
 end
);
end
;
var_8.ConfigEnabled=false;
var_8.ConfigFolder="centrlbeta";
var_8.ConfigFile="config";
var_8.Ext=".cc";
do
 var_8.load=function(v157,v158) local var_63=var_6;
var_63.Parent=var_5;
local var_64=var_63.main;
local var_65=var_64:FindFirstChild("work");
local var_66=var_64.Bar:FindFirstChild("barinner");
var_63.Enabled=true;
var_64.BackgroundTransparency=807 -806 ;
var_64.Bar.BackgroundTransparency=49 -48 ;
var_66.BackgroundTransparency=1;
var_64.Shadow.Image.ImageTransparency=1 + 0 ;
var_64.work.TextTransparency=1887 -1886 ;
var_64.logo.ImageTransparency=3 -2 ;
var_64.UIScale.Scale=732.85 -732 ;
local var_67={Logo="rbxassetid://"   .. v158.Logo ,Cfolder=v158.Cfolder,ConfigEnabled=v158.ConfigEnabled or {Enabled=false} ,Cfolder=(v158.ConfigEnabled and v158.ConfigEnabled.Cfolder) or var_8.ConfigFolder ,Cfile=(v158.ConfigEnabled and v158.ConfigEnabled.Cfile) or var_8.ConfigFile ,Accent=(v158.Theme and v158.Theme.Accent) or var_8.theme.Accent ,Hitbox=(v158.Theme and v158.Theme.Hitbox) or var_8.theme.Hitbox };
var_67.Logo=var_67.Logo or "http://www.roblox.com/asset/?id=18404006294" ;
var_67.Cfolder=var_67.Cfolder or var_8.FolderName ;
var_67.Accent=var_67.Accent;
var_67.Hitbox=var_67.Hitbox;
var_64.logo.Image=var_67.Logo;
if (var_67.ConfigEnabled.Enabled==nil) then
 var_67.ConfigEnabled.Enabled=false;
end
 task.wait(1);
v1:Create(var_64,TweenInfo.new(0.3 -0 ,Enum.EasingStyle.Exponential,Enum.EasingDirection.Out),{BackgroundTransparency=0}):Play();
v1:Create(var_64.UIScale,TweenInfo.new(0.3,Enum.EasingStyle.Exponential,Enum.EasingDirection.Out),{Scale=98 -97 }):Play();
v1:Create(var_64.Bar,TweenInfo.new(0.3 -0 ,Enum.EasingStyle.Exponential,Enum.EasingDirection.Out),{BackgroundTransparency=285 -285 }):Play();
v1:Create(var_66,TweenInfo.new(0.3 -0 ,Enum.EasingStyle.Exponential,Enum.EasingDirection.Out),{BackgroundTransparency=0 -0 }):Play();
v1:Create(var_64.Shadow.Image,TweenInfo.new(1796.3 -1796 ,Enum.EasingStyle.Exponential,Enum.EasingDirection.Out),{ImageTransparency=0.4}):Play();
v1:Create(var_64.work,TweenInfo.new(0.3 -0 ,Enum.EasingStyle.Exponential,Enum.EasingDirection.Out),{TextTransparency=0}):Play();
v1:Create(var_64.logo,TweenInfo.new(0.3 + 0 ,Enum.EasingStyle.Exponential,Enum.EasingDirection.Out),{ImageTransparency=1061 -1061 }):Play();
v1:Create(var_64,TweenInfo.new(0.5,Enum.EasingStyle.Quint,Enum.EasingDirection.Out),{Position=UDim2.new(0.5 + 0 ,0 + 0 ,0.5,0 + 0 )}):Play();
task.wait(533.7 -533 );
v1:Create(var_64,TweenInfo.new(733.7 -733 ,Enum.EasingStyle.Quint,Enum.EasingDirection.Out),{Size=UDim2.new(0,1740 -1290 ,0,1149 -859 )}):Play();
v1:Create(var_64.logo,TweenInfo.new(0.7,Enum.EasingStyle.Quint,Enum.EasingDirection.Out),{Position=UDim2.new(0.5 + 0 , -100,0 + 0 ,1789 -1744 )}):Play();
v1:Create(var_64.Bar,TweenInfo.new(405.7 -405 ,Enum.EasingStyle.Quint,Enum.EasingDirection.Out),{Position=UDim2.new(0.5 + 0 ,49 + 41 ,0 -0 ,150)}):Play();
task.wait(0.044 -0 );
v1:Create(var_64.work,TweenInfo.new(1739.7 -1739 ,Enum.EasingStyle.Quint,Enum.EasingDirection.Out),{Position=UDim2.new(406.5 -406 ,109 -19 ,0 + 0 ,60 + 105 )}):Play();
task.wait(337.7 -337 );
v1:Create(var_64.powerd,TweenInfo.new(0.5 + 0 ,Enum.EasingStyle.Exponential,Enum.EasingDirection.Out),{TextTransparency=0}):Play();
task.wait(338.5 -338 );
v1:Create(var_64.bld,TweenInfo.new(0.5,Enum.EasingStyle.Exponential,Enum.EasingDirection.Out),{TextTransparency=0}):Play();
local var_68=2 + 2 ;
local function v179(v246) var_66:TweenSize(UDim2.new(v246/var_68 ,449 -449 ,1 + 0 ,0 -0 ),Enum.EasingDirection.Out,Enum.EasingStyle.Quint,1493.5 -1493 ,true);
end
 var_65.Text="Checking/Adding Files...";
wait();
if var_67.ConfigEnabled.Enabled then
 var_8.ConfigEnabled=true;
var_8.ConfigFolder=var_67.ConfigEnabled.Cfolder;
var_8.ConfigFile=var_67.ConfigEnabled.Cfile;
end
 if  not isfolder(var_8.ConfigFolder) then
 makefolder(var_8.ConfigFolder);
end
 print("UI Folder Loaded |",var_67.Cfolder);
if var_66 then
 v179(1 -0 );
end
 task.wait(470 -469 );
var_65.Text="Checking for discord...";
if var_66 then
 v179(1 + 1 );
end
 task.wait(1820 -1819 );
var_65.Text="Securing...";
if var_66 then
 v179(3);
end
 task.wait(2 -1 );
var_65.Text="Loading UI...";
var_8.theme.Accent=var_67.Accent;
var_8.theme.Hitbox=var_67.Hitbox;
if var_66 then
 v179(4 + 0 );
end
 task.wait(1 + 1 );
v1:Create(var_64.Bar,TweenInfo.new(0.3 + 0 ,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{BackgroundTransparency=2 -1 }):Play();
v1:Create(var_66,TweenInfo.new(0.3 + 0 ,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{BackgroundTransparency=1168 -1167 }):Play();
v1:Create(var_64.Shadow.Image,TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{ImageTransparency=1}):Play();
v1:Create(var_64.work,TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{TextTransparency=1791 -1790 }):Play();
v1:Create(var_64.powerd,TweenInfo.new(0.3 + 0 ,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{TextTransparency=4 -3 }):Play();
v1:Create(var_64.bld,TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{TextTransparency=2 -1 }):Play();
v1:Create(var_64.logo,TweenInfo.new(1836.3 -1836 ,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{ImageTransparency=2 -1 }):Play();
task.wait(0.32 -0 );
v1:Create(var_64,TweenInfo.new(505.7 -505 ,Enum.EasingStyle.Quint,Enum.EasingDirection.Out),{Size=UDim2.new(0,2258 -1574 ,0,764 -266 )}):Play();
v1:Create(var_64,TweenInfo.new(0.3 -0 ,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{BackgroundTransparency=1560 -1559 }):Play();
task.wait(0.035 + 0 );
v1:Create(var_64.UIScale,TweenInfo.new(0.3 + 0 ,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{Scale=0.85}):Play();
task.wait(0.8 + 0 );
var_63:Destroy();
wait(3 -2 );
var_7.Enabled=true;
end
;
end
 var_8.util.ui=var_7;
var_8.util.window=var_8.util.ui.lib;
var_8.util.topbar=var_8.util.window.top;
var_8.util.tabholder=var_8.util.window.tabhlder.tbls;
var_8.util.pageholder=var_8.util.window.pages;
local var_13=var_8.util.ui;
local var_14=var_8.util.window;
local var_15=var_8.util.topbar;
local var_16=var_8.util.tabholder;
local var_17=var_8.util.pageholder;
local function v50(v93) if v93 then
 var_7.Parent=v93;
else
 warn("Failed to set Centrl parent.");
end
 end
 if gethui then
 v50(gethui());
elseif (syn and syn.protect_gui) then
 local var_138=0;
while true do
 if (var_138==0) then
 syn.protect_gui(var_7);
v50(var_5);
break;
end
 end
 elseif var_5:FindFirstChild("RobloxGui") then
 v50(var_5:FindFirstChild("RobloxGui"));
else
 warn("No valid parent found for Centrl.");
end
 local function v51(v94) for v184,v185 in ipairs(v94:GetChildren()) do
 if ((v185.Name==var_7.Name) and (v185~=var_7)) then
 local var_139=0;
while true do
 if (0==var_139) then
 v185.Enabled=false;
v185.Name=var_7.Name   .. "-Old" ;
var_139=1 + 0 ;
end
 if (var_139==1) then
 print("Disabled and renamed old instance: "   .. v185.Name );
break;
end
 end
 end
 end
 end
 if gethui then
 v51(gethui());
else
 v51(var_5);
end
 var_8.util.removeplaceholder(var_8.util.tabholder,"tb");
var_8.util.removeplaceholder(var_8.util.pageholder,"page");
var_8.util.removeplaceholder(var_8.util.pageholder.page.L,"section");
var_8.util.removeplaceholder(var_14.clipframe.settings.Frame.ScrollingFrame,"section");
function LoadConfig(v95) local var_27=0;
local var_28;
local var_29;
while true do
 if (var_27==(470 -470)) then
 var_28=var_1:JSONDecode(v95);
var_29=false;
var_27=1 + 0 ;
end
 if (var_27==1) then
 for v650,v651 in pairs(var_8.Flags) do
 local var_226=0 + 0 ;
local var_227;
while true do
 if (var_226==0) then
 var_227=var_28[v650];
if var_227 then
 task.spawn(function() if v651.Set then
 v651:Set(((v651.Type=="ColorPicker") and var_8.util.ColorUnpack(var_227)) or var_227 );
elseif ((v651.Type=="ColorPicker") and v651.Color) then
 v651.Color=var_8.util.ColorUnpack(var_227);
var_29=true;
elseif (v651.Value~=nil) then
 v651.Value=var_227;
var_29=true;
elseif v651.startvalue then
 v651.startvalue=var_227;
else
 warn("Unsupported flag type or missing setter for flag: "   .. v650 );
end
 end
);
else
 warn("Centrl | Unable to find '"   .. v650   .. "' in the save file." );
print("This may happen if this was first executed or new elements added.");
end
 break;
end
 end
 end
 return var_29;
end
 end
 end
 function SaveConfig() local var_30=0;
local var_31;
while true do
 if (var_30==1) then
 for v654,v655 in pairs(var_8.Flags) do
 if (v655.Type=="ColorPicker") then
 var_31[v654]=var_8.util.ColorPack(v655.Color);
else
 var_31[v654]=v655.Value or v655.Color or v655.startvalue or false ;
end
 end
 if writefile then
 local var_270=1156 -1156 ;
local var_271;
while true do
 if (var_270==0) then
 var_271=string.format("%s/%s/%s%s",var_8.ConfigFolder,"configs",var_8.ConfigFile,var_8.Ext);
writefile(var_271,var_1:JSONEncode(var_31));
break;
end
 end
 end
 break;
end
 if (var_30==0) then
 if  not var_8.ConfigEnabled then
 return;
end
 var_31={};
var_30=1;
end
 end
 end
 var_8.int=function(v101,v102) local var_32={first=false,selected=false};
local var_33={title=v102.Title,subtitle=v102.Sub};
local var_34={settopen=false};
local var_35={searchopen=false};
task.wait(1784.04 -1784 );
var_8.util.AddDrag(var_15,var_14,0.2);
var_8.util.MakeResizeable(var_14.resize,var_14,Vector2.new(2109 -1455 ,428));
var_13.Enabled=true;
var_15.title.Text=var_33.title;
var_15.title.subtitle.Text=var_33.subtitle;
v1:Create(var_15.title,TweenInfo.new(0.5,Enum.EasingStyle.Quart,Enum.EasingDirection.Out),{Size=UDim2.new(0,var_15.title.TextBounds.X + 4 + 4 ,0,13 + 15 )}):Play();
if  not var_34.settopen then
 v1:Create(var_14.clipframe.settings,TweenInfo.new(0.5 + 0 ,Enum.EasingStyle.Quint,Enum.EasingDirection.Out),{Position=UDim2.new(1,300,0 -0 ,1736 -1726 )}):Play();
end
 var_34.Section=function(v186,v187,v188) local var_69={};
local var_70=var_14.clipframe.settings.Frame.ScrollingFrame.section:Clone();
var_70.Visible=true;
var_70.Parent=var_14.clipframe.settings.Frame.ScrollingFrame;
var_70.Title.Text=v187;
local function v195() var_70.UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() var_70:TweenSize(UDim2.new(627 -626 ,0,0 -0 ,var_70.UIListLayout.AbsoluteContentSize.Y + 10 ),Enum.EasingDirection.Out,Enum.EasingStyle.Quart,0.5,true);
end
);
end
 v195();
for v248,v249 in ipairs(var_70:GetChildren()) do
 if v249:IsA("Frame") then
 v249:Destroy();
end
 end
 if  not v188 then
 var_70.Title.Warn.Visible=false;
else
 local var_140=0 -0 ;
while true do
 if (var_140==0) then
 var_70.Title.Warn.Visible=true;
var_70.Title.Warn.TextLabel.Text=v188;
break;
end
 end
 end
 var_70.Title.Warn.TextLabel.Size=UDim2.new(0 + 0 ,var_70.Title.Warn.TextLabel.TextBounds.X,0 + 0 ,9 + 1 );
var_70.Title.Warn.Size=UDim2.new(0 -0 ,var_70.Title.Warn.TextLabel.TextBounds.X + (2019 -1994) ,1469 -1469 ,28 -13 );
var_69.createToggle=function(v250,v251) local var_90={Title=v251.Title,Callback=v251.Callback,Value=v251.Value or false };
local var_91=var_14.clipframe.settings.Frame.ScrollingFrame.section.toggle:Clone();
var_91.Visible=true;
var_91.Parent=var_70;
var_91.title.Text=var_90.Title;
var_91.Name=var_90.Title;
local var_92=var_13.togconfig:Clone();
var_92.Visible=false;
var_92.Parent=var_13.renders;
var_92.Reset.ImageLabel.ImageTransparency=1;
var_92.Reset.BackgroundTransparency=815.85 -815 ;
var_92.Bind.BackgroundTransparency=826.85 -826 ;
if  not var_90.Value then
 var_91.tog.BackgroundColor3=Color3.fromRGB(20,34 -14 ,25 -5 );
var_91.title.TextTransparency=0.6 + 0 ;
var_91.tog.check.ImageTransparency=1 + 0 ;
var_91.tog.check.Visible=false;
var_91.tog.check:TweenPosition(UDim2.new(0.5 + 0 ,0 + 0 ,0.5 -0 ,13 -9 ),Enum.EasingDirection.Out,Enum.EasingStyle.Quad,0.2 + 0 );
var_91.tog.gradfr.BackgroundTransparency=1;
else
 var_91.tog.BackgroundColor3=var_8.theme.Hitbox;
var_91.title.TextTransparency=0;
var_91.tog.check.ImageTransparency=0.3 + 0 ;
var_91.tog.check.Visible=true;
var_91.tog.check:TweenPosition(UDim2.new(0.5 + 0 ,0 + 0 ,0.5 + 0 ,1433 -1433 ),Enum.EasingDirection.Out,Enum.EasingStyle.Quad,0.2 -0 );
var_91.tog.gradfr.BackgroundTransparency=1619 -1619 ;
end
 local function v266() var_90.Value= not var_90.Value;
if var_90.Value then
 local var_272=0;
while true do
 if (var_272==2) then
 v1:Create(var_91.tog.check.UIScale,TweenInfo.new(0.3 + 0 ,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{Scale=2 -1 }):Play();
v1:Create(var_91.tog.check,TweenInfo.new(0.3 + 0 ,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{ImageTransparency=0.3}):Play();
var_272=2 + 1 ;
end
 if (var_272==(329 -326)) then
 var_91.tog.check:TweenPosition(UDim2.new(1276.5 -1276 ,0 + 0 ,0.5,0 + 0 ),Enum.EasingDirection.Out,Enum.EasingStyle.Quad,0.5,true);
break;
end
 if (var_272==1) then
 v1:Create(var_91.tog.gradfr,TweenInfo.new(0.4,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{BackgroundTransparency=0 -0 }):Play();
var_91.tog.check.Visible=true;
var_272=553 -551 ;
end
 if (var_272==(1806 -1806)) then
 v1:Create(var_91.title,TweenInfo.new(0.3 -0 ,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{TextTransparency=0}):Play();
v1:Create(var_91.tog,TweenInfo.new(0.3 -0 ,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{BackgroundColor3=var_8.theme.Hitbox}):Play();
var_272=2 -1 ;
end
 end
 else
 v1:Create(var_91.title,TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{TextTransparency=325.6 -325 }):Play();
v1:Create(var_91.tog,TweenInfo.new(0.5 + 0 ,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{BackgroundColor3=Color3.fromRGB(18 + 2 ,8 + 12 ,20)}):Play();
v1:Create(var_91.tog.check,TweenInfo.new(0.3 + 0 ,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{ImageTransparency=1}):Play();
v1:Create(var_91.tog.check.UIScale,TweenInfo.new(0.3 + 0 ,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{Scale=0.3}):Play();
var_91.tog.check:TweenPosition(UDim2.new(0.5 -0 ,0,0.5,10),Enum.EasingDirection.Out,Enum.EasingStyle.Quad,1911.5 -1911 ,true);
v1:Create(var_91.tog.gradfr,TweenInfo.new(0.4 + 0 ,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{BackgroundTransparency=1773 -1772 }):Play();
end
 local var_141,v406=pcall(function() var_90.Callback(var_90.Value);
end
);
if  not var_141 then
 print("error in ["   .. var_91.Name   .. "], "   .. tostring(v406) );
end
 end
 var_91.interact.MouseButton1Click:Connect(v266);
end
;
var_69.createTextInput=function(v267,v268) local var_93={Title=v268.Title or "Textinput" ,Placeholder=v268.Placeholder or "Discord T0ken here." ,Clearonlost=v268.Clearonlost or false ,Callback=v268.Callback};
local var_94=var_14.clipframe.settings.Frame.ScrollingFrame.section.textinput:Clone();
var_94.Visible=true;
var_94.Parent=var_70;
var_94.title.Text=var_93.Title;
var_94.Name=var_93.Title;
var_94.inputbox.TextLabel.Text=var_93.Placeholder;
var_94.inputbox.TextLabel.BackgroundColor3=Color3.fromRGB(321 -204 ,1151 -1034 ,2065 -1948 );
var_94.title.Size=UDim2.new(0 + 0 ,var_94.title.TextBounds.X,1 -0 ,0 + 0 );
local var_95=var_94.inputbox;
local var_96= -var_94.title.TextBounds.X-18 ;
local var_97=var_96-var_95.Size.X.Offset ;
v1:Create(var_95,TweenInfo.new(512.7 -512 ,Enum.EasingStyle.Quint,Enum.EasingDirection.Out),{Size=UDim2.new(var_95.Size.X.Scale,var_96,var_95.Size.Y.Scale,var_95.Size.Y.Offset)}):Play();
var_8.util.registerLoadTween(var_95,{Size=UDim2.new(var_95.Size.X.Scale,var_96,var_95.Size.Y.Scale,var_95.Size.Y.Offset)},{Size=UDim2.new(1, -(290 -236),0,26)},TweenInfo.new(95.7 -95 ,Enum.EasingStyle.Quint,Enum.EasingDirection.Out));
v1:Create(var_95,TweenInfo.new(0.7 + 0 ,Enum.EasingStyle.Quint,Enum.EasingDirection.Out),{Position=var_95.Position-UDim2.new(1317 -1317 ,var_97,726 -726 ,0 + 0 ) }):Play();
var_8.util.registerLoadTween(var_95,{Position=var_95.Position-UDim2.new(0 + 0 ,var_97,663 -663 ,0 -0 ) },{Position=UDim2.new(0,1960 -1905 ,524.567 -524 ,1269 -1269 )},TweenInfo.new(0.7 + 0 ,Enum.EasingStyle.Quint,Enum.EasingDirection.Out));
var_94.inputbox.TextBox.FocusLost:Connect(function(v407) if  not v407 then
 return;
end
 local var_142,v409=pcall(function() var_93.Callback(var_94.inputbox.TextBox.Text);
end
);
if var_93.Clearonlost then
 var_94.inputbox.TextBox.Text="";
end
 if  not var_142 then
 print("error ["   .. var_94.Name   .. "], "   .. tostring(v409) );
end
 end
);
var_94.inputbox.submit.MouseButton1Click:Connect(function() local var_143,v411=pcall(function() var_93.Callback(var_94.inputbox.TextBox.Text);
end
);
if var_93.Clearonlost then
 var_94.inputbox.TextBox.Text="";
end
 if  not var_143 then
 print("error ["   .. var_94.Name   .. "], "   .. tostring(v411) );
end
 end
);
var_94.inputbox.submit.MouseEnter:Connect(function() v1:Create(var_94.inputbox.submit.load,TweenInfo.new(1162.4 -1162 ,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{ImageTransparency=0 -0 }):Play();
end
);
var_94.inputbox.submit.MouseLeave:Connect(function() v1:Create(var_94.inputbox.submit.load,TweenInfo.new(0.4 -0 ,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{ImageTransparency=0.7}):Play();
end
);
local var_95=var_94.inputbox;
local var_98=var_95:WaitForChild("TextBox");
local var_99=var_95:WaitForChild("ImageLabel");
local var_100=var_95:WaitForChild("TextLabel");
var_99.Visible=false;
var_99.AnchorPoint=Vector2.new(0 -0 ,0.5 + 0 );
var_100.AnchorPoint=Vector2.new(0 -0 ,0.5 -0 );
var_100.Position=UDim2.new(0 -0 ,0 -0 ,1248.5 -1248 ,0);
local function v290() local var_144=0;
local var_145;
local var_146;
local var_147;
local var_148;
local var_149;
local var_150;
local var_151;
while true do
 if (var_144==3) then
 var_100.Text=var_98.Text;
var_100.Position=UDim2.new(0,158 -158 ,0.5 -0 ,0 + 0 );
break;
end
 if (var_144==(524 -523)) then
 var_147=var_3:GetTextSize(var_146,var_98.TextSize,var_98.Font,Vector2.new(math.huge,var_98.AbsoluteSize.Y));
var_148=math.min(var_147.X,var_98.AbsoluteSize.X-1 );
var_149=UDim2.new(0,var_148 + 1 + 10 ,0.5,0 -0 );
var_144=2 + 0 ;
end
 if (var_144==0) then
 var_145=var_98.CursorPosition-(772 -771) ;
if (var_145<0) then
 var_145=0 -0 ;
end
 var_146=string.sub(var_98.Text,2 -1 ,var_145);
var_144=1;
end
 if (var_144==(713 -711)) then
 var_150=TweenInfo.new(0.2,Enum.EasingStyle.Sine,Enum.EasingDirection.Out);
var_151=v1:Create(var_99,var_150,{Position=var_149});
var_151:Play();
var_144=3;
end
 end
 end
 var_98:GetPropertyChangedSignal("Text"):Connect(v290);
var_98:GetPropertyChangedSignal("CursorPosition"):Connect(v290);
var_98.Focused:Connect(function() local var_152=881 -881 ;
while true do
 if (var_152==1) then
 v1:Create(var_100,TweenInfo.new(32.3 -32 ,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{TextColor3=Color3.fromRGB(414 -159 ,255,255)}):Play();
v290();
break;
end
 if (var_152==0) then
 var_99.Visible=true;
v1:Create(var_99,TweenInfo.new(0.3 -0 ,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{BackgroundTransparency=0 -0 }):Play();
var_152=1;
end
 end
 end
);
var_98.FocusLost:Connect(function() v1:Create(var_99,TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{BackgroundTransparency=1 + 0 }):Play();
v1:Create(var_100,TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{TextColor3=Color3.fromRGB(205 -88 ,242 -125 ,1929 -1812 )}):Play();
var_100.Text=var_93.Placeholder;
task.wait(0.3 -0 );
var_99.Visible=false;
end
);
v4.InputBegan:Connect(function(v424) if ((v424.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) and var_98:IsFocused()) then
 local var_273=0 -0 ;
while true do
 if (var_273==0) then
 wait();
v290();
break;
end
 end
 end
 end
);
var_98.Changed:Connect(function(v425) if ((v425=="Text") or (v425=="CursorPosition")) then
 v290();
end
 end
);
end
;
var_69.createSlider=function(v291,v292) local var_101={Title=v292.Title or "Slider" ,Sliders=v292.Sliders};
local var_102=var_14.clipframe.settings.Frame.ScrollingFrame.section.slider:Clone();
var_102.Visible=true;
var_102.Parent=var_70;
var_102.title.Text=var_101.Title;
var_102.Name=var_101.Title;
var_102.slidelist.slideholder.Visible=false;
for v426,v427 in pairs(var_101.Sliders) do
 local var_153=var_14.clipframe.settings.Frame.ScrollingFrame.section.slider.slidelist.slideholder:Clone();
v427={title=v427.title or "slide" ,increment=v427.increment or 1 ,range=v427.range or {0 -0 ,100} ,startvalue=v427.startvalue or 16 ,callback=v427.callback};
local var_154={dragging=false};
var_153.Visible=true;
var_153.Parent=var_102.slidelist;
var_153.sliderframe.suffix.Text=v427.title or var_153.sliderframe.suffix:Destroy() ;
local var_155;
if (v427.startvalue<=v427.range[1]) then
 var_155=0;
elseif (v427.startvalue>=v427.range[1 + 1 ]) then
 var_155=2 -1 ;
else
 local var_329=v427.range[1 + 1 ] -v427.range[1 + 0 ] ;
var_155=(v427.startvalue-v427.range[1 + 0 ])/var_329 ;
end
 var_153.sliderframe.slide:TweenSize(UDim2.new(var_155,1096 -1096 ,0,1863 -1858 ),Enum.EasingDirection.Out,Enum.EasingStyle.Quad,0.2 -0 ,true);
var_153.sliderframe.value.Text="<font size= '14'>"   .. tostring(v427.startvalue)   .. "</font>"   .. "<font color='rgb(86, 86, 86)'>/"   .. v427.range[6 -4 ]   .. "</font>" ;
local function v436(v667) if var_154.dragging then
 local var_292=0;
local var_293;
local var_294;
local var_295;
local var_296;
local var_297;
local var_298;
while true do
 if (0==var_292) then
 var_293=(v667-var_153.sliderframe.AbsolutePosition.X)/var_153.sliderframe.AbsoluteSize.X ;
var_293=math.clamp(var_293,0 + 0 ,1 + 0 );
var_294=v427.range[2] -v427.range[1 -0 ] ;
var_295=v427.range[1 + 0 ] + (var_293 * var_294) ;
var_292=1 -0 ;
end
 if (var_292==1) then
 var_296=var_3:GetTextSize(tostring(var_295)   .. "/"   .. v427.range[3 -1 ] ,1894 -1880 ,Enum.Font.SourceSans,Vector2.new(math.huge,math.huge));
var_295=(math.floor(((var_295-v427.range[1284 -1283 ])/v427.increment) + 0.5 ) * v427.increment) + v427.range[2 -1 ] ;
var_153.sliderframe.slide:TweenSize(UDim2.new(var_293,1847 -1847 ,1931 -1931 ,5),Enum.EasingDirection.Out,Enum.EasingStyle.Quart,454.3 -454 ,true);
var_153.sliderframe.value.Text="<font size= '14'>"   .. tostring(var_295)   .. "</font>"   .. "<font color='rgb(86, 86, 86)'>/"   .. v427.range[7 -5 ]   .. "</font>" ;
var_292=2;
end
 if (var_292==2) then
 v1:Create(var_153.sliderframe.suffix,TweenInfo.new(0.3 -0 ,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{TextTransparency=0 + 0 }):Play();
var_297,var_298=pcall(function() v427.callback(var_295);
end
);
if  not var_297 then
 print("error in ["   .. var_153.Name   .. "], "   .. tostring(var_298) );
end
 break;
end
 end
 end
 end
 var_153.sliderframe.interact.MouseButton1Down:Connect(function(v668) local var_228=0 -0 ;
while true do
 if (0==var_228) then
 var_154.dragging=true;
v436(v668);
break;
end
 end
 end
);
var_153.sliderframe.interact.MouseButton1Up:Connect(function() var_154.dragging=false;
end
);
var_8.util.AddConnection(v4.InputEnded,function(v671,v672) if (v671.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
 local var_299=0 + 0 ;
while true do
 if (var_299==0) then
 var_154.dragging=false;
v1:Create(var_153.sliderframe.suffix,TweenInfo.new(0.3 + 0 ,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{TextTransparency=0.64 -0 }):Play();
var_299=1 + 0 ;
end
 if (var_299==1) then
 v1:Create(var_153.sliderframe.value,TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{BackgroundTransparency=1 + 0 }):Play();
var_153.sliderframe.value:TweenPosition(UDim2.new(1 + 0 ,0 + 0 ,0 + 0 , -(445 -433)),Enum.EasingDirection.Out,Enum.EasingStyle.Quint,0.2 -0 ,true);
break;
end
 end
 end
 end
);
var_8.util.AddConnection(v4.InputChanged,function(v673) if (var_154.dragging and (v673.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch)) then
 v436(v673.Position.X);
end
 end
);
var_153.sliderframe.slide.BackgroundColor3=var_8.theme.Hitbox;
var_102.slidelist.Size=UDim2.new(1 + 0 ,0 + 0 ,0,var_102.slidelist.UIListLayout.AbsoluteContentSize.Y);
var_102.Size=UDim2.new(1, -20,0 + 0 ,var_102.slidelist.AbsoluteSize.Y + 21 + 7 );
var_8.util.AddConnection(var_8.Comms.Event,function(v674,v675) if (v674=="Hitbox") then
 var_153.sliderframe.slide.BackgroundColor3=v675;
end
 end
);
end
 end
;
var_69.ColorPicker=function(v301,v302) local var_103={Title=v302.Title or "colorpicker" ,Color=v302.Color,Callback=v302.Callback};
local var_104=var_14.clipframe.settings.Frame.ScrollingFrame.section.colorpicker:Clone();
var_104.Visible=true;
var_104.Parent=var_70;
var_104.title.Text=var_103.Title;
var_104.Name=var_103.Title;
local var_105=var_13.pickerconfig:Clone();
var_105.Parent=var_13.renders;
var_105.Visible=false;
local var_106=false;
local var_107=false;
local var_108=false;
var_104.container.SVPicker.BackgroundTransparency=1 -0 ;
var_104.container.Hue.BackgroundTransparency=1 + 0 ;
if  not var_108 then
 local var_229=0;
while true do
 if (0==var_229) then
 v1:Create(var_104.config,TweenInfo.new(667.7 -667 ,Enum.EasingStyle.Quart,Enum.EasingDirection.Out),{ImageTransparency=1 + 0 }):Play();
v1:Create(var_104.config,TweenInfo.new(0.6 -0 ,Enum.EasingStyle.Quart,Enum.EasingDirection.Out),{Position=UDim2.new(1050 -1049 , -20,0 + 0 ,2 + 13 )}):Play();
break;
end
 end
 end
 var_104.MouseEnter:Connect(function() v1:Create(var_104.config,TweenInfo.new(0.6,Enum.EasingStyle.Quart,Enum.EasingDirection.Out),{Position=UDim2.new(1, -(118 -86),0 -0 ,15)}):Play();
v1:Create(var_104.config,TweenInfo.new(0.7 + 0 ,Enum.EasingStyle.Quart,Enum.EasingDirection.Out),{ImageTransparency=0}):Play();
end
);
var_104.MouseLeave:Connect(function() if  not var_108 then
 v1:Create(var_104.config,TweenInfo.new(842.7 -842 ,Enum.EasingStyle.Quart,Enum.EasingDirection.Out),{ImageTransparency=1 + 0 }):Play();
v1:Create(var_104.config,TweenInfo.new(0.6 + 0 ,Enum.EasingStyle.Quart,Enum.EasingDirection.Out),{Position=UDim2.new(1334 -1333 , -20,0,33 -18 )}):Play();
end
 end
);
local function v319() var_106=true;
var_107=true;
var_104:TweenSize(UDim2.new(1 + 0 , -10,0 + 0 ,471 -301 ),Enum.EasingDirection.Out,Enum.EasingStyle.Quart,0.5 + 0 ,true);
wait(0.5);
var_104.container.Visible=true;
v1:Create(var_104.container.SVPicker,TweenInfo.new(0.4,Enum.EasingStyle.Quart,Enum.EasingDirection.Out),{BackgroundTransparency=0}):Play();
v1:Create(var_104.container.Hue,TweenInfo.new(489.4 -489 ,Enum.EasingStyle.Quart,Enum.EasingDirection.Out),{BackgroundTransparency=0}):Play();
var_107=false;
end
 local function v320() var_106=false;
var_107=true;
v1:Create(var_104.container.SVPicker,TweenInfo.new(0.3,Enum.EasingStyle.Quart,Enum.EasingDirection.Out),{BackgroundTransparency=1}):Play();
v1:Create(var_104.container.Hue,TweenInfo.new(0.3 + 0 ,Enum.EasingStyle.Quart,Enum.EasingDirection.Out),{BackgroundTransparency=1403 -1402 }):Play();
var_104:TweenSize(UDim2.new(1, -10,0 + 0 ,99 -71 ),Enum.EasingDirection.Out,Enum.EasingStyle.Quart,0.4,true);
wait(0.4);
var_104.container.Visible=false;
var_107=false;
end
 var_104.setcolor.MouseButton1Click:Connect(function() local var_156=0;
while true do
 if (var_156==0) then
 if var_107 then
 return;
end
 if  not var_106 then
 var_106=true;
v319();
else
 local var_353=0;
while true do
 if (0==var_353) then
 var_106=false;
v320();
break;
end
 end
 end
 break;
end
 end
 end
);
local var_109;
if var_103.Color then
 var_109={var_103.Color:ToHSV()};
else
 var_109={1800 -1800 ,0 + 0 ,1889 -1889 };
end
 local var_110=var_103.Color;
local var_111=var_109[1 + 0 ];
local function v324(v444) if (type(v444)~="table") then
 return v444;
end
 return Color3.fromHSV(v444[1 + 0 ],v444[6 -4 ],v444[608 -605 ]);
end
 local function v325(v445,v446,v447) local var_157=0 -0 ;
local var_158;
while true do
 if (0==var_157) then
 v446=v446 or "RGB" ;
v447=v447 or 2 ;
var_157=1;
end
 if (var_157==1) then
 var_158="";
if (v446=="RGB") then
 return math.round(v445.R * 255 )   .. ","   .. math.round(v445.G * (1708 -1453) )   .. ","   .. math.round(v445.B * (680 -425) ) ;
elseif (v446=="Hex") then
 local var_379=0 + 0 ;
while true do
 if (var_379==(254 -254)) then
 var_158=string.format("#%02X%02X%02X",math.round(v445.R * 255 ),math.round(v445.G * 255 ),math.round(v445.B * 255 ));
return var_158;
end
 end
 end
 break;
end
 end
 end
 local var_112=var_104.container.SVPicker;
local var_113=var_104.container.Hue;
local function v328() var_103.Color=v324(var_109);
var_104.setcolor.BackgroundColor3=var_103.Color;
var_112.BackgroundColor3=Color3.fromHSV(var_109[1 -0 ],1,1);
v1:Create(var_112.Pin,TweenInfo.new(899.3 -899 ,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{Position=UDim2.new(var_109[2],181 -181 ,1 -var_109[2 + 1 ] ,0)}):Play();
v1:Create(var_113.Pin,TweenInfo.new(0.3 + 0 ,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{Position=UDim2.new(1 -var_109[1] ,0 + 0 ,0.5 -0 ,0 + 0 )}):Play();
local var_159=v325(var_103.Color,"Hex");
var_104.container.HEX.HEXBox.Text=var_159;
local var_160=v325(var_103.Color,"RGB",1 + 1 );
var_104.container.RGB.RGBBox.Text=var_160;
if var_103.Callback then
 var_103.Callback(var_103.Color);
end
 end
 v328();
local var_114,v330=nil,nil;
var_8.util.AddConnection(var_112.InputBegan,function(v457) if (v457.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
 var_114=v3.RenderStepped:Connect(function() local var_300=var_112.AbsolutePosition;
local var_301=game.Players.LocalPlayer:GetMouse();
local var_302=var_112.AbsoluteSize;
local var_303=math.clamp(var_301.X-var_112.AbsolutePosition.X ,0 -0 ,var_112.AbsoluteSize.X)/var_112.AbsoluteSize.X ;
var_112.Pin:TweenSize(UDim2.new(0 + 0 ,25,0 -0 ,25),Enum.EasingDirection.Out,Enum.EasingStyle.Quart,1244.5 -1244 ,true);
local var_304=math.clamp(var_301.Y-(var_112.AbsolutePosition.Y + 0) ,0,var_112.AbsoluteSize.Y)/var_112.AbsoluteSize.Y ;
var_109[2]=var_303;
var_109[1192 -1189 ]=1 -var_304 ;
v328();
end
);
end
 end
);
var_8.util.AddConnection(var_112.InputEnded,function(v458) if (v458.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
 if var_114 then
 local var_330=1135 -1135 ;
while true do
 if (var_330==(946 -946)) then
 var_112.Pin:TweenSize(UDim2.new(0,4 + 6 ,0 + 0 ,1 + 9 ),Enum.EasingDirection.Out,Enum.EasingStyle.Quint,0.3,true);
var_114:Disconnect();
break;
end
 end
 end
 end
 end
);
var_8.util.AddConnection(var_113.InputBegan,function(v459) if (v459.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
 v330=v3.RenderStepped:Connect(function() local var_305=0;
local var_306;
local var_307;
while true do
 if ((789 -789)==var_305) then
 var_306=game.Players.LocalPlayer:GetMouse();
var_113.Pin:TweenSize(UDim2.new(0,113 -90 ,0 -0 ,60 -37 ),Enum.EasingDirection.Out,Enum.EasingStyle.Quart,0.5 -0 ,true);
var_305=1074 -1073 ;
end
 if (var_305==1) then
 var_307=math.clamp(var_306.X-var_113.AbsolutePosition.X ,0 -0 ,var_113.AbsoluteSize.X)/var_113.AbsoluteSize.X ;
var_109[1 + 0 ]=(1481 -1480) -var_307 ;
var_305=915 -913 ;
end
 if (var_305==2) then
 v328();
break;
end
 end
 end
);
end
 end
);
var_8.util.AddConnection(var_113.InputEnded,function(v460) if (v460.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
 if v330 then
 var_113.Pin:TweenSize(UDim2.new(0 -0 ,10,1684 -1684 ,5 + 5 ),Enum.EasingDirection.Out,Enum.EasingStyle.Quint,1148.3 -1148 ,true);
v330:Disconnect();
end
 end
 end
);
local var_115=0.005;
local var_111=0;
local var_116=false;
local function v333() while var_116 do
 local var_230=0 + 0 ;
while true do
 if (var_230==(809 -808)) then
 v328();
wait(854.03 -854 );
break;
end
 if (var_230==0) then
 var_111=(var_111 + var_115)%1 ;
var_109[1]=var_111;
var_230=1 -0 ;
end
 end
 end
 end
 local var_117=nil;
local function v335() var_116= not var_116;
if var_116 then
 if  not var_117 then
 local var_331=0;
while true do
 if (var_331==1) then
 v1:Create(var_104.container.Rainbow.Tick,TweenInfo.new(739.3 -739 ,Enum.EasingStyle.Quart,Enum.EasingDirection.Out),{BackgroundColor3=var_8.theme.Hitbox}):Play();
break;
end
 if (var_331==0) then
 var_117=coroutine.create(v333);
coroutine.resume(var_117);
var_331=1478 -1477 ;
end
 end
 end
 elseif var_117 then
 local var_332=0;
while true do
 if (var_332==(1390 -1389)) then
 var_117=nil;
break;
end
 if (var_332==0) then
 var_116=false;
v1:Create(var_104.container.Rainbow.Tick,TweenInfo.new(0.3 -0 ,Enum.EasingStyle.Quart,Enum.EasingDirection.Out),{BackgroundColor3=Color3.fromRGB(20 + 10 ,1557 -1527 ,30)}):Play();
var_332=1;
end
 end
 end
 end
 var_104.container.Rainbow.MouseButton1Click:Connect(v335);
var_104.container.HEX.HEXBox.FocusLost:Connect(function(v461) if  not v461 then
 return;
end
 local var_161=var_104.container.HEX.HEXBox.Text;
local var_162,v464=pcall(function() return Color3.fromHex(var_161);
end
);
if var_162 then
 local var_274,v808,v809=v464:ToHSV();
var_104.container.HEX.HEXBox.Text="";
var_104.container.RGB.RGBBox.Text="";
var_109[575 -574 ]=var_274;
var_109[2]=v808;
var_109[3 + 0 ]=v809;
v328();
else
 warn("Failed to convert hex to color:",v464);
end
 end
);
var_104.container.RGB.RGBBox.FocusLost:Connect(function(v465) local var_163=0 + 0 ;
local var_164;
local var_165;
local var_166;
local var_167;
while true do
 if (var_163==1) then
 var_165,var_166,var_167=var_164:match("^(%d+),%s*(%d+),%s*(%d+)$");
if (var_165 and var_166 and var_167) then
 local var_354=0 + 0 ;
while true do
 if (var_354==(1545 -1545)) then
 var_165,var_166,var_167=tonumber(var_165),tonumber(var_166),tonumber(var_167);
if ((var_165>=0) and (var_165<=255) and (var_166>=0) and (var_166<=(1719 -1464)) and (var_167>=0) and (var_167<=(2114 -1859))) then
 local var_387=Color3.fromRGB(var_165,var_166,var_167);
local var_388,v1100,v1101=var_387:ToHSV();
var_109[2 -1 ]=var_388;
var_109[1 + 1 ]=v1100;
var_109[4 -1 ]=v1101;
var_104.container.HEX.HEXBox.Text="";
var_104.container.RGB.RGBBox.Text="";
v328();
else
 warn("RGB values must be between 0 and 255.");
end
 break;
end
 end
 else
 warn("Invalid RGB format. Please use the format 'R,G,B' (e.g., 16,16,16).");
end
 break;
end
 if (var_163==0) then
 if  not v465 then
 return;
end
 var_164=var_104.container.RGB.RGBBox.Text;
var_163=1 + 0 ;
end
 end
 end
);
var_104.config.MouseEnter:Connect(function() v1:Create(var_104.config,TweenInfo.new(0.2 -0 ,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{ImageColor3=Color3.fromRGB(255,1281 -1026 ,255)}):Play();
v1:Create(var_104.config,TweenInfo.new(0.2 + 0 ,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{ImageTransparency=0}):Play();
end
);
var_104.config.MouseLeave:Connect(function() local var_168=0;
while true do
 if (0==var_168) then
 v1:Create(var_104.config,TweenInfo.new(0.2 + 0 ,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{ImageColor3=Color3.fromRGB(63,2 + 61 ,97 -34 )}):Play();
v1:Create(var_104.config,TweenInfo.new(304.2 -304 ,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{ImageTransparency=0.61 + 0 }):Play();
break;
end
 end
 end
);
local function v336() var_105.Visible=true;
var_108=true;
v1:Create(var_105,TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{BackgroundTransparency=0 -0 }):Play();
v1:Create(var_105.Copy.TextLabel,TweenInfo.new(362.3 -362 ,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{TextTransparency=0 + 0 }):Play();
v1:Create(var_105.UIStroke,TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{Transparency=0 -0 }):Play();
v1:Create(var_105.UIScale,TweenInfo.new(0.3 + 0 ,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{Scale=1 + 0 }):Play();
end
 local function v337() local var_169=0 + 0 ;
while true do
 if (var_169==1) then
 v1:Create(var_105.Copy.TextLabel,TweenInfo.new(0.3 + 0 ,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{TextTransparency=1}):Play();
v1:Create(var_105.UIStroke,TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{Transparency=1 + 0 }):Play();
var_169=2;
end
 if (var_169==3) then
 var_105.Visible=false;
var_105:TweenPosition(UDim2.new(0,1414 -1414 ,0,0 -0 ),Enum.EasingDirection.Out,Enum.EasingStyle.Quad,882.1 -882 ,true);
break;
end
 if (var_169==(693 -693)) then
 var_108=false;
v1:Create(var_105,TweenInfo.new(0.3 -0 ,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{BackgroundTransparency=603 -602 }):Play();
var_169=1907 -1906 ;
end
 if (var_169==(719 -717)) then
 v1:Create(var_105.UIScale,TweenInfo.new(0.3 + 0 ,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{Scale=0.5 + 0 }):Play();
task.wait(0.3);
var_169=3;
end
 end
 end
 local var_118;
local var_119=false;
local function v340() if var_119 then
 return;
end
 var_119=true;
if  not var_105.Visible then
 var_118=v3.RenderStepped:Connect(function() var_105:TweenPosition(UDim2.new(0 -0 ,var_104.config.AbsolutePosition.X,0 -0 ,var_104.config.AbsolutePosition.Y + var_104.config.AbsoluteSize.Y + 65 ),Enum.EasingDirection.Out,Enum.EasingStyle.Quad,1099.1 -1099 ,true);
if  not var_105.Visible then
 var_118:Disconnect();
end
 end
);
v336();
else
 if var_118 then
 var_118:Disconnect();
end
 v337();
end
 task.delay(0.4 + 0 ,function() var_119=false;
end
);
end
 var_104.config.MouseButton1Click:Connect(function() v340();
end
);
var_105.Selection.HEX.MouseEnter:Connect(function() v1:Create(var_105.Selection.HEX,TweenInfo.new(0.4 -0 ,Enum.EasingStyle.Quart,Enum.EasingDirection.Out),{BackgroundTransparency=0.7}):Play();
end
);
var_105.Selection.HEX.MouseLeave:Connect(function() v1:Create(var_105.Selection.HEX,TweenInfo.new(0.4,Enum.EasingStyle.Quart,Enum.EasingDirection.Out),{BackgroundTransparency=0.85 + 0 }):Play();
end
);
var_105.Selection.RGB.MouseEnter:Connect(function() v1:Create(var_105.Selection.RGB,TweenInfo.new(1236.4 -1236 ,Enum.EasingStyle.Quart,Enum.EasingDirection.Out),{BackgroundTransparency=0.7}):Play();
end
);
var_105.Selection.RGB.MouseLeave:Connect(function() v1:Create(var_105.Selection.RGB,TweenInfo.new(1259.4 -1259 ,Enum.EasingStyle.Quart,Enum.EasingDirection.Out),{BackgroundTransparency=1666.85 -1666 }):Play();
end
);
local var_120=1 + 0 ;
local var_121=false;
var_105.Selection.HEX.interact.MouseButton1Click:Connect(function() if var_121 then
 return;
end
 var_121=true;
if var_103.Color then
 local var_275=v325(var_103.Color,"Hex");
setclipboard(var_275);
print("Color copied to clipboard:",var_275);
v1:Create(var_105.Selection.HEX.TextLabel,TweenInfo.new(0.5,Enum.EasingStyle.Quart,Enum.EasingDirection.Out),{TextTransparency=1 + 0 }):Play();
v1:Create(var_105.Selection.HEX.ImageLabel,TweenInfo.new(0.5 + 0 ,Enum.EasingStyle.Quart,Enum.EasingDirection.Out),{ImageTransparency=0}):Play();
task.wait(2);
v1:Create(var_105.Selection.HEX.TextLabel,TweenInfo.new(0.5 + 0 ,Enum.EasingStyle.Quart,Enum.EasingDirection.Out),{TextTransparency=0}):Play();
v1:Create(var_105.Selection.HEX.ImageLabel,TweenInfo.new(221.5 -221 ,Enum.EasingStyle.Quart,Enum.EasingDirection.Out),{ImageTransparency=1}):Play();
end
 task.wait(var_120);
var_121=false;
end
);
var_105.Selection.RGB.interact.MouseButton1Click:Connect(function() if var_121 then
 return;
end
 var_121=true;
if var_103.Color then
 local var_276=var_104.container.RGB.RGBBox.PlaceholderText;
setclipboard(var_276);
print("Color copied to clipboard:",var_276);
v1:Create(var_105.Selection.RGB.TextLabel,TweenInfo.new(0.5 + 0 ,Enum.EasingStyle.Quart,Enum.EasingDirection.Out),{TextTransparency=1}):Play();
v1:Create(var_105.Selection.RGB.ImageLabel,TweenInfo.new(0.5 + 0 ,Enum.EasingStyle.Quart,Enum.EasingDirection.Out),{ImageTransparency=0 -0 }):Play();
task.wait(299 -297 );
v1:Create(var_105.Selection.RGB.TextLabel,TweenInfo.new(0.5 -0 ,Enum.EasingStyle.Quart,Enum.EasingDirection.Out),{TextTransparency=0}):Play();
v1:Create(var_105.Selection.RGB.ImageLabel,TweenInfo.new(1368.5 -1368 ,Enum.EasingStyle.Quart,Enum.EasingDirection.Out),{ImageTransparency=1 + 0 }):Play();
end
 task.wait(var_120);
var_121=false;
end
);
end
;
return var_69;
end
;
local var_36=var_34:Section("Theme");
local var_37=var_34:Section("Particles","May Cause Performance issues.");
local var_38=var_34:Section("Privacy");
var_38:createToggle({Title="Show Profile (not working)",Callback=function(v202) print("coming soon");
end
});
var_36:ColorPicker({Title="Accent",Color=var_8.theme.Accent,Callback=function(v203) var_8:UpdateTheme({Accent=v203});
end
});
var_36:ColorPicker({Title="Hitbox",Color=var_8.theme.Hitbox,Callback=function(v204) var_8:UpdateTheme({Hitbox=v204});
end
});
var_36:ColorPicker({Title="Glow",Color=var_8.theme.Glow,Callback=function(v205) var_8:UpdateTheme({Glow=v205});
end
});
var_36:createTextInput({Title="Cursor",Placeholder="Enter Img ID.",Clearonlost=false,Callback=function(v206) local var_71=0;
local var_72;
local var_73;
local var_74;
local var_75;
local var_76;
while true do
 if (var_71==4) then
 var_76.BackgroundTransparency=1284 -1283 ;
var_76.Image=var_72;
var_76.AnchorPoint=Vector2.new(21.5 -21 ,0.5);
var_71=3 + 2 ;
end
 if (var_71==(321 -319)) then
 var_75.ResetOnSpawn=false;
var_75.IgnoreGuiInset=true;
var_75.Parent=var_74:WaitForChild("PlayerGui");
var_71=1136 -1133 ;
end
 if (var_71==0) then
 var_72="rbxassetid://"   .. v206 ;
var_73=Vector2.new(50,50);
var_74=game.Players.LocalPlayer;
var_71=686 -685 ;
end
 if (var_71==5) then
 var_76.ZIndex=999999;
var_76.Parent=var_7;
v3.RenderStepped:Connect(function() local var_277=0 -0 ;
local var_278;
while true do
 if (var_277==(968 -968)) then
 var_278=v4:GetMouseLocation();
var_76.Position=UDim2.new(0,var_278.X,0,var_278.Y);
break;
end
 end
 end
);
break;
end
 if (var_71==1) then
 v4.MouseIconEnabled=false;
var_75=Instance.new("ScreenGui");
var_75.Name="CustomCursorGui";
var_71=2;
end
 if ((1175 -1172)==var_71) then
 var_76=Instance.new("ImageLabel");
var_76.Name="CustomCursor";
var_76.Size=UDim2.new(0 -0 ,var_73.X,1379 -1379 ,var_73.Y);
var_71=1344 -1340 ;
end
 end
 end
});
var_36:createSlider({Title="Shadow Density",Sliders={{title="Density",range={0 + 0 ,3 -2 },increment=0.1 -0 ,startvalue=var_14.Shadow.Image.ImageTransparency,callback=function(v213) v1:Create(var_14.Shadow.Image,TweenInfo.new(0.5 -0 ,Enum.EasingStyle.Quint,Enum.EasingDirection.Out),{ImageTransparency=v213}):Play();
end
}}});
local var_39=var_14.Frame;
local var_40=game.Players.LocalPlayer;
local var_41=var_40:GetMouse();
local var_42=2 + 3 ;
local var_43=385 -285 ;
local var_44={};
local var_45={};
local var_46=false;
local function v124() if (var_42==0) then
 local var_170=0 + 0 ;
while true do
 if (0==var_170) then
 for v959= #var_45,2 -1 , -1 do
 local var_333=688 -688 ;
while true do
 if (var_333==0) then
 var_45[v959]:Destroy();
table.remove(var_45,v959);
break;
end
 end
 end
 return;
end
 end
 end
 for v343= #var_45,var_42 + 1 , -1 do
 var_45[v343]:Destroy();
table.remove(var_45,v343);
end
 for v344= #var_45 + 1 ,var_42 do
 local var_122=0;
local var_123;
while true do
 if (0==var_122) then
 var_123=Instance.new("Frame");
var_123.Name="Line"   .. v344 ;
var_122=1 + 0 ;
end
 if (3==var_122) then
 var_123.BackgroundColor3=Color3.fromRGB(255,408 -153 ,774 -519 );
table.insert(var_45,var_123);
break;
end
 if (var_122==1) then
 var_123.AnchorPoint=Vector2.new(0.5,1268.5 -1268 );
var_123.BackgroundTransparency=0.9;
var_122=2 + 0 ;
end
 if (2==var_122) then
 var_123.Size=UDim2.new(1086 -1086 ,1,0 + 0 ,1);
var_123.Parent=var_39;
var_122=232 -229 ;
end
 end
 end
 end
 local function v125() if (var_43==0) then
 local var_171=811 -811 ;
while true do
 if (var_171==1) then
 return;
end
 if (var_171==0) then
 for v961,v962 in pairs(var_44) do
 v962.object:Destroy();
end
 var_44={};
var_171=3 -2 ;
end
 end
 end
 for v347= #var_44,var_43 + 1 , -(471 -470) do
 var_44[v347].object:Destroy();
table.remove(var_44,v347);
end
 for v348= #var_44 + 1 ,var_43 do
 local var_124=0 -0 ;
local var_125;
local var_126;
while true do
 if (var_124==0) then
 var_125=Instance.new("Frame");
var_125.Size=UDim2.new(0 + 0 ,1,0 + 0 ,1 + 0 );
var_124=1 -0 ;
end
 if (3==var_124) then
 var_126={object=var_125,x=math.random(513 -513 ,var_39.AbsoluteSize.X),y=math.random(1993 -1993 ,var_39.AbsoluteSize.Y),taken=false};
var_125.Position=UDim2.new(0 + 0 ,var_126.x,1534 -1534 ,var_126.y);
var_124=7 -3 ;
end
 if (var_124==2) then
 var_125.Parent=var_39;
var_125.BackgroundTransparency=864.8 -864 ;
var_124=11 -8 ;
end
 if (var_124==4) then
 table.insert(var_44,var_126);
break;
end
 if (var_124==1) then
 var_125.BackgroundColor3=Color3.new(1,834 -833 ,1);
var_125.BorderSizePixel=0;
var_124=2;
end
 end
 end
 end
 local function v126() for v352,v353 in pairs(var_44) do
 local var_127=93 -93 ;
while true do
 if (0==var_127) then
 v353.x=math.random(0 -0 ,var_39.AbsoluteSize.X);
v353.y=math.random(0 + 0 ,var_39.AbsoluteSize.Y);
var_127=4 -3 ;
end
 if (var_127==1) then
 v353.object.Position=UDim2.new(1486 -1486 ,v353.x,1453 -1453 ,v353.y);
break;
end
 end
 end
 end
 local function v127() for v355,v356 in pairs(var_44) do
 v356.x=v356.x + (math.random( -1,1994 -1993 ) * (0.5 + 0)) ;
v356.y=v356.y + (math.random( -(1515 -1514),1 -0 ) * (0.5 + 0)) ;
if (v356.x<(297 -297)) then
 v356.x=var_39.AbsoluteSize.X;
end
 if (v356.x>var_39.AbsoluteSize.X) then
 v356.x=0;
end
 if (v356.y<0) then
 v356.y=var_39.AbsoluteSize.Y;
end
 if (v356.y>var_39.AbsoluteSize.Y) then
 v356.y=0 + 0 ;
end
 v356.object.Position=UDim2.new(0 + 0 ,v356.x,0 -0 ,v356.y);
end
 end
 local function v128(v214) local var_77=nil;
local var_78=math.huge;
for v360,v361 in pairs(var_44) do
 if  not v361.taken then
 local var_231=(Vector2.new(v361.x,v361.y) -v214).Magnitude;
if (var_231<var_78) then
 var_78=var_231;
var_77=v361;
end
 end
 end
 return var_77;
end
 local function v129() if var_46 then
 local var_172=0;
local var_173;
while true do
 if (var_172==(434 -433)) then
 for v963,v964 in pairs(var_45) do
 local var_334=v128(var_173);
if var_334 then
 local var_366=0;
local var_367;
local var_368;
local var_369;
local var_370;
local var_371;
local var_372;
local var_373;
while true do
 if (2==var_366) then
 var_370=var_368.Magnitude;
var_371=TweenInfo.new(0 -0 ,Enum.EasingStyle.Sine,Enum.EasingDirection.Out);
var_366=3 -0 ;
end
 if (1==var_366) then
 var_368=var_173-var_367 ;
var_369=math.deg(math.atan2(var_368.Y,var_368.X));
var_366=2;
end
 if (var_366==3) then
 var_372={Size=UDim2.new(0 + 0 ,var_370,0 -0 ,1 -0 ),Position=UDim2.new(1963 -1963 ,var_367.X + (var_368.X/2) ,1206 -1206 ,var_367.Y + (var_368.Y/(467 -465)) ),Rotation=var_369,Visible=true};
var_373=v1:Create(v964,var_371,var_372);
var_366=3 + 1 ;
end
 if (var_366==4) then
 var_373:Play();
break;
end
 if (var_366==0) then
 var_334.taken=true;
var_367=Vector2.new(var_334.x,var_334.y);
var_366=1 + 0 ;
end
 end
 else
 v1:Create(v964,TweenInfo.new(0.3 + 0 ,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{BackgroundTransparency=1 + 0 }):Play();
end
 end
 break;
end
 if (var_172==(1230 -1230)) then
 for v966,v967 in pairs(var_44) do
 v967.taken=false;
end
 var_173=Vector2.new(var_41.X-var_39.AbsolutePosition.X ,var_41.Y-var_39.AbsolutePosition.Y );
var_172=1 + 0 ;
end
 end
 else
 for v698,v699 in pairs(var_45) do
 v699.Visible=false;
end
 end
 end
 var_39.MouseEnter:Connect(function() var_46=true;
end
);
var_39.MouseLeave:Connect(function() var_46=false;
end
);
var_39:GetPropertyChangedSignal("AbsoluteSize"):Connect(v126);
game:GetService("RunService").RenderStepped:Connect(function() local var_79=0;
while true do
 if (var_79==0) then
 v127();
v129();
break;
end
 end
 end
);
v124();
v125();
var_37:createSlider({Title="Particles",Sliders={{title="Lines",range={0 -0 ,10},increment=2 -1 ,startvalue=var_42,callback=function(v218) var_42=v218;
v124();
end
},{title="Particle Count",range={1780 -1780 ,200},increment=10,startvalue=var_43,callback=function(v219) var_43=v219;
v125();
end
}}});
var_15.bholder.settingbframe.MouseEnter:Connect(function() v1:Create(var_15.bholder.settingbframe,TweenInfo.new(0.5,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{BackgroundTransparency=0.4 + 0 }):Play();
end
);
var_15.bholder.settingbframe.MouseLeave:Connect(function() v1:Create(var_15.bholder.settingbframe,TweenInfo.new(0.5 -0 ,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{BackgroundTransparency=1}):Play();
end
);
var_15.bholder.pluginbframe.MouseEnter:Connect(function() v1:Create(var_15.bholder.pluginbframe,TweenInfo.new(951.5 -951 ,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{BackgroundTransparency=0.4}):Play();
end
);
var_15.bholder.pluginbframe.MouseLeave:Connect(function() v1:Create(var_15.bholder.pluginbframe,TweenInfo.new(0.5 -0 ,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{BackgroundTransparency=1 + 0 }):Play();
end
);
var_15.bholder.minivframe.MouseEnter:Connect(function() v1:Create(var_15.bholder.minivframe,TweenInfo.new(311.5 -311 ,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{BackgroundTransparency=0.4 -0 }):Play();
end
);
var_15.bholder.minivframe.MouseLeave:Connect(function() v1:Create(var_15.bholder.minivframe,TweenInfo.new(0.5,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{BackgroundTransparency=1213 -1212 }):Play();
end
);
if  not var_34.settopen then
 v1:Create(var_14.clipframe.settings,TweenInfo.new(0.7,Enum.EasingStyle.Quint,Enum.EasingDirection.Out),{Position=UDim2.new(1 + 0 ,1007 -707 ,0 + 0 ,1128 -1118 )}):Play();
end
 local var_47=1 + 0 ;
local var_48=0;
var_15.bholder.settingbframe.settings.MouseButton1Click:Connect(function() local var_80=tick();
if ( not var_35.searchopen and ((var_80-var_48)>=var_47)) then
 local var_174=0;
while true do
 if (var_174==0) then
 var_48=var_80;
var_34.settopen=true;
var_174=2 -1 ;
end
 if (var_174==2) then
 v1:Create(var_14.clipframe.settings,TweenInfo.new(0.7,Enum.EasingStyle.Quint,Enum.EasingDirection.Out),{Size=UDim2.new(774 -774 , -280,1 -0 , -30)}):Play();
v1:Create(var_14.clipframe.settings,TweenInfo.new(0.5,Enum.EasingStyle.Quint,Enum.EasingDirection.Out),{Position=UDim2.new(1, -10,0 + 0 ,2 + 8 )}):Play();
var_174=1698 -1695 ;
end
 if (var_174==3) then
 v1:Create(var_14.clipframe,TweenInfo.new(15.5 -15 ,Enum.EasingStyle.Quint,Enum.EasingDirection.Out),{BackgroundTransparency=0.5}):Play();
break;
end
 if (1==var_174) then
 v1:Create(var_14.clipframe.settings.Title,TweenInfo.new(0.7 + 0 ,Enum.EasingStyle.Quint,Enum.EasingDirection.Out),{TextTransparency=169 -169 }):Play();
v1:Create(var_14.clipframe.settings.Title.Back,TweenInfo.new(0.7 + 0 ,Enum.EasingStyle.Quint,Enum.EasingDirection.Out),{ImageTransparency=0 -0 }):Play();
var_174=2 + 0 ;
end
 end
 end
 end
);
var_14.clipframe.settings.Title.Back.MouseEnter:Connect(function() local var_81=1317 -1317 ;
while true do
 if (var_81==0) then
 v1:Create(var_14.clipframe.settings.Title.Back,TweenInfo.new(0.5 -0 ,Enum.EasingStyle.Quint,Enum.EasingDirection.Out),{ImageTransparency=0 + 0 }):Play();
v1:Create(var_14.clipframe.settings.Title.Back,TweenInfo.new(0.5 -0 ,Enum.EasingStyle.Quint,Enum.EasingDirection.Out),{Position=UDim2.new(1264 -1263 ,5 + 0 ,0.5,0 + 0 )}):Play();
break;
end
 end
 end
);
var_14.clipframe.settings.Title.Back.MouseLeave:Connect(function() local var_82=0 -0 ;
while true do
 if ((290 -290)==var_82) then
 v1:Create(var_14.clipframe.settings.Title.Back,TweenInfo.new(1944.5 -1944 ,Enum.EasingStyle.Quint,Enum.EasingDirection.Out),{ImageTransparency=387.82 -387 }):Play();
v1:Create(var_14.clipframe.settings.Title.Back,TweenInfo.new(1750.5 -1750 ,Enum.EasingStyle.Quint,Enum.EasingDirection.Out),{Position=UDim2.new(1 -0 ,0 -0 ,0.5,118 -118 )}):Play();
break;
end
 end
 end
);
var_14.clipframe.settings.Title.Back.MouseButton1Click:Connect(function() local var_83=771 -771 ;
local var_84;
while true do
 if (var_83==0) then
 var_84=tick();
if (var_34.settopen and ((var_84-var_48)>=var_47)) then
 var_48=var_84;
var_34.settopen=false;
v1:Create(var_14.clipframe.settings.Title,TweenInfo.new(0.4 -0 ,Enum.EasingStyle.Quint,Enum.EasingDirection.Out),{TextTransparency=1777 -1776 }):Play();
v1:Create(var_14.clipframe.settings.Title.Back,TweenInfo.new(0.4 -0 ,Enum.EasingStyle.Quint,Enum.EasingDirection.Out),{ImageTransparency=1}):Play();
task.wait(0.09);
v1:Create(var_14.clipframe.settings,TweenInfo.new(0.7 + 0 ,Enum.EasingStyle.Quint,Enum.EasingDirection.Out),{Position=UDim2.new(1,1383 -1083 ,0,10)}):Play();
v1:Create(var_14.clipframe,TweenInfo.new(0.7,Enum.EasingStyle.Quint,Enum.EasingDirection.Out),{BackgroundTransparency=3 -2 }):Play();
task.wait(0.7 -0 );
v1:Create(var_14.clipframe.settings,TweenInfo.new(0.7,Enum.EasingStyle.Quint,Enum.EasingDirection.Out),{Size=UDim2.new(0.256, -280,439.247 -439 , -30)}):Play();
end
 break;
end
 end
 end
);
var_8.util.AddConnection(var_8.Comms.Event,function(v225,v226) if (v225=="Glow") then
 var_14.Shadow.Image.ImageColor3=v226;
end
 end
);
var_32.IntTab=function(v227,v228) local var_85={};
local var_86;
local var_87=var_16.tb:Clone();
var_87.Visible=true;
var_87.Parent=var_16;
var_87.title.Text=v228;
var_87.Name=v228;
local var_88=var_17.page:Clone();
var_88.Visible=false;
var_88.Parent=var_17;
var_88.Name=v228;
for v362,v363 in ipairs(var_88.L.section.Container:GetChildren()) do
 if v363:IsA("Frame") then
 v363:Destroy();
end
 end
 var_88.L.ListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() if (var_88.L.ListLayout.AbsoluteContentSize.Y>var_88.R.ListLayout.AbsoluteContentSize.Y) then
 var_88.CanvasSize=UDim2.new(800 -800 ,0 -0 ,785 -785 ,var_88.L.ListLayout.AbsoluteContentSize.Y + 20 );
else
 var_88.CanvasSize=UDim2.new(0 + 0 ,0,190 -190 ,var_88.R.ListLayout.AbsoluteContentSize.Y + (1818 -1798) );
end
 end
);
var_88.R.ListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() if (var_88.R.ListLayout.AbsoluteContentSize.Y>var_88.L.ListLayout.AbsoluteContentSize.Y) then
 var_88.CanvasSize=UDim2.new(0 + 0 ,0 + 0 ,0,var_88.R.ListLayout.AbsoluteContentSize.Y + (868 -848) );
else
 var_88.CanvasSize=UDim2.new(0 + 0 ,0,0,var_88.L.ListLayout.AbsoluteContentSize.Y + 20 );
end
 end
);
if  not var_32.first then
 var_88.Visible=true;
end
 if var_32.first then
 local var_175=0 + 0 ;
while true do
 if (var_175==1) then
 v1:Create(var_87.indi,TweenInfo.new(0.5 + 0 ,Enum.EasingStyle.Quart,Enum.EasingDirection.Out),{BackgroundTransparency=572 -571 }):Play();
v1:Create(var_87.indi,TweenInfo.new(0.5 + 0 ,Enum.EasingStyle.Quart,Enum.EasingDirection.Out),{BackgroundColor3=Color3.fromRGB(79 -50 ,42 -13 ,65 -36 )}):Play();
break;
end
 if (var_175==(1726 -1726)) then
 v1:Create(var_87.title,TweenInfo.new(0.5 + 0 ,Enum.EasingStyle.Quart,Enum.EasingDirection.Out),{Position=UDim2.new(0 -0 ,5,0.5 + 0 ,479 -479 )}):Play();
v1:Create(var_87.title,TweenInfo.new(0.5 + 0 ,Enum.EasingStyle.Quart,Enum.EasingDirection.Out),{TextColor3=Color3.fromRGB(69 -35 ,363 -326 ,151 -104 )}):Play();
var_175=1 -0 ;
end
 end
 else
 var_32.first=v228;
v1:Create(var_87.title,TweenInfo.new(881.5 -881 ,Enum.EasingStyle.Quart,Enum.EasingDirection.Out),{Position=UDim2.new(0,1240 -1220 ,0.5 -0 ,0 + 0 )}):Play();
v1:Create(var_87.title,TweenInfo.new(1235.5 -1235 ,Enum.EasingStyle.Quart,Enum.EasingDirection.Out),{TextColor3=Color3.fromRGB(140,143,159)}):Play();
v1:Create(var_87.indi,TweenInfo.new(0.5,Enum.EasingStyle.Quart,Enum.EasingDirection.Out),{BackgroundTransparency=0}):Play();
v1:Create(var_87.indi,TweenInfo.new(0.5 + 0 ,Enum.EasingStyle.Quart,Enum.EasingDirection.Out),{BackgroundColor3=var_8.theme.Accent}):Play();
end
 local function v240(v364) for v483,v484 in ipairs(var_16:GetChildren()) do
 if v484:IsA("TextButton") then
 if (v484==v364) then
 v1:Create(v484.title,TweenInfo.new(0.5,Enum.EasingStyle.Quint,Enum.EasingDirection.Out),{Position=UDim2.new(0 + 0 ,306 -286 ,0.5 -0 ,0 -0 )}):Play();
v1:Create(v484.title,TweenInfo.new(0.5 -0 ,Enum.EasingStyle.Quart,Enum.EasingDirection.Out),{TextColor3=Color3.fromRGB(140,38 + 105 ,93 + 66 )}):Play();
v1:Create(v484.indi,TweenInfo.new(69.5 -69 ,Enum.EasingStyle.Quart,Enum.EasingDirection.Out),{BackgroundTransparency=0}):Play();
v1:Create(v484.indi,TweenInfo.new(0.5,Enum.EasingStyle.Quart,Enum.EasingDirection.Out),{BackgroundColor3=var_8.theme.Accent}):Play();
else
 v1:Create(v484.title,TweenInfo.new(0.5,Enum.EasingStyle.Quint,Enum.EasingDirection.Out),{Position=UDim2.new(0 + 0 ,24 -19 ,1163.5 -1163 ,0 + 0 )}):Play();
v1:Create(v484.title,TweenInfo.new(1215.5 -1215 ,Enum.EasingStyle.Quart,Enum.EasingDirection.Out),{TextColor3=Color3.fromRGB(34,10 + 27 ,41 + 6 )}):Play();
v1:Create(v484.indi,TweenInfo.new(1945.5 -1945 ,Enum.EasingStyle.Quart,Enum.EasingDirection.Out),{BackgroundTransparency=1}):Play();
v1:Create(v484.indi,TweenInfo.new(0.5,Enum.EasingStyle.Quart,Enum.EasingDirection.Out),{BackgroundColor3=Color3.fromRGB(29,24 + 5 ,48 -19 )}):Play();
end
 end
 end
 end
 var_87.MouseButton1Click:Connect(function() if (var_32.first==v228) then
 return;
else
 for v834,v835 in ipairs(var_17:GetChildren()) do
 if v835:IsA("ScrollingFrame") then
 v835.Visible=false;
end
 end
 var_88.Visible=true;
var_8.util.replayLoadTweens();
var_32.first=v228;
v240(var_87);
end
 end
);
var_8.util.AddConnection(var_8.Comms.Event,function(v365,v366) if ((v365=="Tab Unselected") or "Tab Selected") then
 local var_232=0;
local var_233;
while true do
 if (var_232==(203 -203)) then
 var_233=var_16:FindFirstChild(var_32.first);
if (var_233 and var_233:IsA("TextButton")) then
 v240(var_233);
end
 break;
end
 end
 end
 end
);
var_85.IntSection=function(v367,v368,v369) local var_128={Side=v369.Side or var_8.util.GetSide( #var_88.L:GetChildren(), #var_88.R:GetChildren()) };
local var_129={};
local var_130=var_88.L.section:Clone();
var_130.Visible=true;
var_130.Parent=var_88[var_128.Side];
var_130.titlefr.title.Text=v368;
var_130.Name=v368;
for v485,v486 in ipairs(var_130.Container:GetChildren()) do
 if v486:IsA("Frame") then
 v486:Destroy();
end
 end
 local function v378() var_130.Container.UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() var_130:TweenSize(UDim2.new(1 + 0 ,175 -175 ,0,var_130.Container.UIListLayout.AbsoluteContentSize.Y + 50 ),Enum.EasingDirection.Out,Enum.EasingStyle.Quint,0.3,true);
end
);
end
 v378();
var_129.createButton=function(v487,v488) local var_176=0 -0 ;
local var_177;
local var_178;
while true do
 if (var_176==1) then
 var_178.Visible=true;
var_178.Parent=var_130.Container;
var_176=2;
end
 if (3==var_176) then
 var_178.interact.MouseButton1Click:Connect(function() local var_335=0 -0 ;
local var_336;
local var_337;
while true do
 if (var_335==(176 -176)) then
 var_336,var_337=pcall(function() var_177.Callback(var_177.Callback);
end
);
if  not var_336 then
 print("error ["   .. var_178.Name   .. "], "   .. tostring(var_337) );
end
 break;
end
 end
 end
);
break;
end
 if (var_176==2) then
 var_178.title.Text=var_177.Title;
var_178.Name=var_177.Title;
var_176=1 + 2 ;
end
 if (0==var_176) then
 var_177={Title=v488.Title,Callback=v488.Callback};
var_178=var_17.page.L.section.Container.button:Clone();
var_176=1414 -1413 ;
end
 end
 end
;
var_129.createToggle=function(v492,v493) local var_179={Title=v493.Title,Callback=v493.Callback,Value=v493.Value or false ,Config=v493.Config or false ,Flag=v493.Flag};
var_179.Value=var_179.Value or false ;
var_179.Config=var_179.Config or false ;
local var_180=var_17.page.L.section.Container.toggle:Clone();
var_180.Visible=true;
var_180.Parent=var_130.Container;
var_180.title.Text=var_179.Title;
var_180.Name=var_179.Title;
local var_181=var_13.togconfig:Clone();
var_181.Visible=false;
var_181.Parent=var_13.renders;
var_181.Reset.ImageLabel.ImageTransparency=970 -969 ;
var_181.Reset.BackgroundTransparency=1421.85 -1421 ;
var_181.Bind.BackgroundTransparency=0.85 + 0 ;
if (var_179.Config==false) then
 var_180.config:Destroy();
end
 if (var_179.Value==false) then
 var_180.tog.BackgroundColor3=Color3.fromRGB(60 -40 ,20,9 + 11 );
var_180.title.TextTransparency=0.6 -0 ;
var_180.tog.check.ImageTransparency=3 -2 ;
var_180.tog.check.Visible=false;
var_180.tog.check:TweenPosition(UDim2.new(1910.5 -1910 ,0 + 0 ,0.5 + 0 ,507 -503 ),Enum.EasingDirection.Out,Enum.EasingStyle.Quad,0.2);
var_180.tog.gradfr.BackgroundTransparency=1 -0 ;
else
 var_180.tog.BackgroundColor3=var_8.theme.Hitbox;
var_180.title.TextTransparency=0 + 0 ;
var_180.tog.check.ImageTransparency=0.3 -0 ;
var_180.tog.check.Visible=true;
var_180.tog.check:TweenPosition(UDim2.new(0.5 + 0 ,0 -0 ,0.5 -0 ,0),Enum.EasingDirection.Out,Enum.EasingStyle.Quad,0.2);
var_180.tog.gradfr.BackgroundTransparency=433 -433 ;
end
 local function v511() if (var_179.Value==false) then
 local var_308=0;
while true do
 if (var_308==3) then
 v1:Create(var_180.tog.check,TweenInfo.new(778.3 -778 ,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{ImageTransparency=0.3 + 0 }):Play();
var_180.tog.check:TweenPosition(UDim2.new(17.5 -17 ,0 + 0 ,0.5 -0 ,0 + 0 ),Enum.EasingDirection.Out,Enum.EasingStyle.Quad,1093.5 -1093 ,true);
break;
end
 if (var_308==1) then
 v1:Create(var_180.tog,TweenInfo.new(1183.3 -1183 ,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{BackgroundColor3=var_8.theme.Hitbox}):Play();
v1:Create(var_180.tog.gradfr,TweenInfo.new(0.4 + 0 ,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{BackgroundTransparency=0}):Play();
var_308=2;
end
 if (var_308==(977 -975)) then
 var_180.tog.check.Visible=true;
v1:Create(var_180.tog.check.UIScale,TweenInfo.new(0.3 -0 ,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{Scale=2 -1 }):Play();
var_308=1 + 2 ;
end
 if (var_308==0) then
 var_179.Value=true;
v1:Create(var_180.title,TweenInfo.new(0.3 -0 ,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{TextTransparency=1898 -1898 }):Play();
var_308=1894 -1893 ;
end
 end
 else
 local var_309=0;
while true do
 if (var_309==3) then
 v1:Create(var_180.tog.gradfr,TweenInfo.new(0.4,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{BackgroundTransparency=1}):Play();
break;
end
 if (var_309==0) then
 var_179.Value=false;
v1:Create(var_180.title,TweenInfo.new(0.3 -0 ,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{TextTransparency=0.6}):Play();
var_309=1;
end
 if (var_309==2) then
 v1:Create(var_180.tog.check.UIScale,TweenInfo.new(1182.3 -1182 ,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{Scale=0.3}):Play();
var_180.tog.check:TweenPosition(UDim2.new(1774.5 -1774 ,1579 -1579 ,0.5 + 0 ,10),Enum.EasingDirection.Out,Enum.EasingStyle.Quad,0.5 + 0 ,true);
var_309=6 -3 ;
end
 if (var_309==1) then
 v1:Create(var_180.tog,TweenInfo.new(679.5 -679 ,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{BackgroundColor3=Color3.fromRGB(20,20,5 + 15 )}):Play();
v1:Create(var_180.tog.check,TweenInfo.new(0.3 + 0 ,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{ImageTransparency=2 -1 }):Play();
var_309=456 -454 ;
end
 end
 end
 local var_234,v710=pcall(function() var_179.Callback(var_179.Value);
end
);
if  not var_234 then
 print("error in ["   .. var_180.Name   .. "], "   .. tostring(v710) );
end
 SaveConfig();
end
 var_180.interact.MouseButton1Click:Connect(v511);
if var_179.Config then
 local var_279=false;
var_180.MouseEnter:Connect(function() v1:Create(var_180.config,TweenInfo.new(0.6,Enum.EasingStyle.Quart,Enum.EasingDirection.Out),{Position=UDim2.new(2 -1 , -32,1541.5 -1541 ,0 + 0 )}):Play();
v1:Create(var_180.config,TweenInfo.new(0.7,Enum.EasingStyle.Quart,Enum.EasingDirection.Out),{ImageTransparency=805 -805 }):Play();
end
);
var_180.MouseLeave:Connect(function() if  not var_279 then
 local var_355=0 -0 ;
while true do
 if (var_355==(1225 -1225)) then
 v1:Create(var_180.config,TweenInfo.new(0.6,Enum.EasingStyle.Quart,Enum.EasingDirection.Out),{Position=UDim2.new(1, -20,0.5,0 -0 )}):Play();
v1:Create(var_180.config,TweenInfo.new(0.7 -0 ,Enum.EasingStyle.Quart,Enum.EasingDirection.Out),{ImageTransparency=1}):Play();
break;
end
 end
 end
 end
);
if  not var_279 then
 local var_338=0;
while true do
 if (var_338==0) then
 v1:Create(var_180.config,TweenInfo.new(0.6 + 0 ,Enum.EasingStyle.Quart,Enum.EasingDirection.Out),{Position=UDim2.new(1016 -1015 , -20,0.5,0 -0 )}):Play();
v1:Create(var_180.config,TweenInfo.new(0.7 -0 ,Enum.EasingStyle.Quart,Enum.EasingDirection.Out),{ImageTransparency=1188 -1187 }):Play();
break;
end
 end
 end
 var_180.config.MouseEnter:Connect(function() local var_310=0 + 0 ;
while true do
 if (var_310==0) then
 v1:Create(var_180.config,TweenInfo.new(0.2 -0 ,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{ImageColor3=Color3.fromRGB(2087 -1832 ,1089 -834 ,174 + 81 )}):Play();
v1:Create(var_180.config,TweenInfo.new(0.2 -0 ,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{ImageTransparency=0}):Play();
break;
end
 end
 end
);
var_180.config.MouseLeave:Connect(function() v1:Create(var_180.config,TweenInfo.new(0.2 + 0 ,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{ImageColor3=Color3.fromRGB(63,1306 -1243 ,63)}):Play();
v1:Create(var_180.config,TweenInfo.new(0.2,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{ImageTransparency=0.61 -0 }):Play();
end
);
local function v848() local var_311=0 -0 ;
while true do
 if (var_311==3) then
 v1:Create(var_181.Bind.BindFrame.a,TweenInfo.new(0.3 -0 ,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{TextTransparency=0 -0 }):Play();
v1:Create(var_181.UIStroke,TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{Transparency=819 -819 }):Play();
var_311=7 -3 ;
end
 if (var_311==1) then
 v1:Create(var_181,TweenInfo.new(1931.3 -1931 ,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{BackgroundTransparency=0}):Play();
v1:Create(var_181.Reset,TweenInfo.new(0.3 + 0 ,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{BackgroundTransparency=1217.85 -1217 }):Play();
var_311=2 -0 ;
end
 if (var_311==2) then
 v1:Create(var_181.Bind.TextLabel,TweenInfo.new(0.3 -0 ,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{TextTransparency=859 -859 }):Play();
v1:Create(var_181.Reset.TextLabel,TweenInfo.new(0.3 -0 ,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{TextTransparency=0 + 0 }):Play();
var_311=840 -837 ;
end
 if (var_311==4) then
 v1:Create(var_181.UIScale,TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{Scale=1 + 0 }):Play();
break;
end
 if (0==var_311) then
 var_181.Visible=true;
var_279=true;
var_311=1 + 0 ;
end
 end
 end
 local function v849() var_279=false;
v1:Create(var_181,TweenInfo.new(0.3 -0 ,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{BackgroundTransparency=521 -520 }):Play();
v1:Create(var_181.Reset,TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{BackgroundTransparency=1283 -1282 }):Play();
v1:Create(var_181.Bind.TextLabel,TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{TextTransparency=2 -1 }):Play();
v1:Create(var_181.Reset.TextLabel,TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{TextTransparency=4 -3 }):Play();
v1:Create(var_181.Bind.BindFrame.a,TweenInfo.new(0.3 + 0 ,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{TextTransparency=391 -390 }):Play();
v1:Create(var_181.Reset.ImageLabel,TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{ImageTransparency=1 -0 }):Play();
v1:Create(var_181.UIStroke,TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{Transparency=1 + 0 }):Play();
v1:Create(var_181.UIScale,TweenInfo.new(0.3 + 0 ,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{Scale=0.5 + 0 }):Play();
task.wait(0.3 -0 );
var_181.Visible=false;
var_181:TweenPosition(UDim2.new(0 + 0 ,0,0,78 -78 ),Enum.EasingDirection.Out,Enum.EasingStyle.Quad,0.1,true);
end
 local var_280;
local var_281=false;
local function v852() if var_281 then
 return;
end
 var_281=true;
if  not var_181.Visible then
 local var_356=0 -0 ;
while true do
 if (0==var_356) then
 var_280=v3.RenderStepped:Connect(function() local var_383=0 + 0 ;
while true do
 if (var_383==0) then
 var_181:TweenPosition(UDim2.new(0 + 0 ,var_180.config.AbsolutePosition.X,0 -0 ,var_180.config.AbsolutePosition.Y + var_180.config.AbsoluteSize.Y + 21 + 44 ),Enum.EasingDirection.Out,Enum.EasingStyle.Quad,901.1 -901 ,true);
if  not var_181.Visible then
 var_280:Disconnect();
end
 break;
end
 end
 end
);
v848();
break;
end
 end
 else
 local var_357=0 -0 ;
while true do
 if (var_357==0) then
 if var_280 then
 var_280:Disconnect();
end
 v849();
break;
end
 end
 end
 task.delay(1868.4 -1868 ,function() var_281=false;
end
);
end
 var_180.config.MouseButton1Click:Connect(function() v852();
end
);
local var_282={};
local var_283=nil;
local var_284=0.4;
local var_285=2 -1 ;
local function v857(v921,v922) if ( not v921 and  not v922) then
 local var_358=0;
while true do
 if (var_358==0) then
 var_181.Bind.BindFrame.a.Text="None";
var_179.Keybind1,var_179.Keybind2=nil,nil;
break;
end
 end
 else
 var_179.Keybind1,var_179.Keybind2=v921,v922;
if v922 then
 local var_380=27 -27 ;
while true do
 if (var_380==0) then
 v1:Create(var_181.Bind.BindFrame.a,TweenInfo.new(0.2,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{TextTransparency=1733 -1732 }):Play();
var_181.Bind.BindFrame.a.Text=v921.Name   .. " + "   .. v922.Name ;
var_380=1 -0 ;
end
 if (var_380==1) then
 v1:Create(var_181.Bind.BindFrame.a,TweenInfo.new(1,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{TextTransparency=1908 -1908 }):Play();
break;
end
 end
 else
 v1:Create(var_181.Bind.BindFrame.a,TweenInfo.new(0.2 + 0 ,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{TextTransparency=1}):Play();
var_181.Bind.BindFrame.a.Text=v921.Name;
v1:Create(var_181.Bind.BindFrame.a,TweenInfo.new(1,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{TextTransparency=0}):Play();
end
 end
 end
 var_181.Bind.interact.MouseButton1Click:Connect(function() v1:Create(var_181.Bind.BindFrame.a,TweenInfo.new(0.2 + 0 ,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{TextTransparency=1 + 0 }):Play();
task.wait(940.2 -940 );
var_181.Bind.BindFrame.a.Text="...";
v1:Create(var_181.Bind.BindFrame.a,TweenInfo.new(0.2 -0 ,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{TextTransparency=0}):Play();
local var_312;
var_312=v4.InputBegan:Connect(function(v974) if (v974.UserInputType==Enum.UserInputType.Keyboard) then
 local var_374=0;
while true do
 if (var_374==(1391 -1390)) then
 task.delay(var_284,function() if (var_282[1 + 0 ] and ((tick() -var_283)>=var_284)) then
 local var_392=0;
local var_393;
while true do
 if (var_392==1) then
 var_393=v4.InputBegan:Connect(function(v1143) if ((v1143.UserInputType==Enum.UserInputType.Keyboard) and (v1143.KeyCode~=var_282[1])) then
 local var_399=0 -0 ;
while true do
 if ((1662 -1661)==var_399) then
 var_393:Disconnect();
var_312:Disconnect();
var_399=2;
end
 if (var_399==(1223 -1223)) then
 var_282[3 -1 ]=v1143.KeyCode;
v857(var_282[1],var_282[2]);
var_399=1;
end
 if (var_399==2) then
 var_282={};
break;
end
 end
 end
 end
);
task.delay(var_285,function() if var_393.Connected then
 local var_400=0 + 0 ;
while true do
 if (var_400==0) then
 v857(var_282[243 -242 ],nil);
var_393:Disconnect();
var_400=1 + 0 ;
end
 if (var_400==1) then
 var_312:Disconnect();
var_282={};
break;
end
 end
 end
 end
);
break;
end
 if (var_392==0) then
 var_181.Bind.BindFrame.a.Text="sk?...";
var_393=nil;
var_392=1;
end
 end
 end
 end
);
break;
end
 if (var_374==0) then
 var_283=tick();
var_282[1 + 0 ]=v974.KeyCode;
var_374=2 -1 ;
end
 end
 end
 end
);
v4.InputEnded:Connect(function(v975) if ((v975.UserInputType==Enum.UserInputType.Keyboard) and (var_282[1 -0 ]==v975.KeyCode)) then
 local var_375=1133 -1133 ;
local var_376;
while true do
 if (var_375==0) then
 var_376=tick() -var_283 ;
if (var_376<var_284) then
 v857(var_282[690 -689 ],nil);
var_312:Disconnect();
var_282={};
end
 break;
end
 end
 end
 end
);
end
);
v4.InputBegan:Connect(function(v925) if (var_179.Keybind1 and var_179.Keybind2) then
 if ((v925.KeyCode==var_179.Keybind1) or (v925.KeyCode==var_179.Keybind2)) then
 local var_381=0 + 0 ;
while true do
 if (var_381==0) then
 var_282[v925.KeyCode]=true;
if (var_282[var_179.Keybind1] and var_282[var_179.Keybind2]) then
 v511();
end
 break;
end
 end
 end
 elseif (var_179.Keybind1 and (v925.KeyCode==var_179.Keybind1)) then
 v511();
end
 end
);
v4.InputEnded:Connect(function(v926) var_282[v926.KeyCode]=nil;
end
);
var_181.Bind.MouseEnter:Connect(function() v1:Create(var_181.Bind,TweenInfo.new(0.4 + 0 ,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{BackgroundTransparency=0.85 + 0 }):Play();
end
);
var_181.Bind.MouseLeave:Connect(function() v1:Create(var_181.Bind,TweenInfo.new(407.4 -407 ,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{BackgroundTransparency=2 -1 }):Play();
end
);
var_181.Reset.MouseEnter:Connect(function() v1:Create(var_181.Reset,TweenInfo.new(0.4 -0 ,Enum.EasingStyle.Quart,Enum.EasingDirection.Out),{BackgroundTransparency=0.7 + 0 }):Play();
v1:Create(var_181.Reset.ImageLabel,TweenInfo.new(1174.4 -1174 ,Enum.EasingStyle.Quart,Enum.EasingDirection.Out),{ImageTransparency=0}):Play();
v1:Create(var_181.Reset.TextLabel.UIPadding,TweenInfo.new(0.4 + 0 ,Enum.EasingStyle.Quart,Enum.EasingDirection.Out),{PaddingLeft=UDim.new(0 + 0 ,70 -47 )}):Play();
end
);
var_181.Reset.MouseLeave:Connect(function() local var_313=0;
while true do
 if (var_313==1) then
 v1:Create(var_181.Reset.TextLabel.UIPadding,TweenInfo.new(0.4,Enum.EasingStyle.Quart,Enum.EasingDirection.Out),{PaddingLeft=UDim.new(0,23 -13 )}):Play();
break;
end
 if (var_313==0) then
 v1:Create(var_181.Reset,TweenInfo.new(0.4 -0 ,Enum.EasingStyle.Quart,Enum.EasingDirection.Out),{BackgroundTransparency=0.85 + 0 }):Play();
v1:Create(var_181.Reset.ImageLabel,TweenInfo.new(0.4 -0 ,Enum.EasingStyle.Quart,Enum.EasingDirection.Out),{ImageTransparency=1 + 0 }):Play();
var_313=1 + 0 ;
end
 end
 end
);
local var_286=false;
var_181.Reset.interact.MouseButton1Click:Connect(function() if var_286 then
 return;
end
 var_286=true;
v857(nil);
local function v929() v1:Create(var_181.Reset.ImageLabel,TweenInfo.new(724 -722 ,Enum.EasingStyle.Elastic,Enum.EasingDirection.Out),{ImageColor3=Color3.fromRGB(255,129,652 -517 )}):Play();
wait(0.3 + 0 );
v1:Create(var_181.Reset.ImageLabel,TweenInfo.new(2,Enum.EasingStyle.Elastic,Enum.EasingDirection.Out),{ImageColor3=Color3.fromRGB(933 -678 ,1635 -1556 ,91)}):Play();
end
 v929();
task.delay(2,function() var_286=false;
end
);
end
);
end
 var_179.Set=function(v711,v712) var_179.Value=v712;
if (var_179.Value==true) then
 local var_314=0 + 0 ;
while true do
 if (var_314==1) then
 v1:Create(var_180.tog.gradfr,TweenInfo.new(0.4 + 0 ,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{BackgroundTransparency=0 -0 }):Play();
var_180.tog.check.Visible=true;
var_314=2;
end
 if (var_314==2) then
 v1:Create(var_180.tog.check.UIScale,TweenInfo.new(1445.3 -1445 ,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{Scale=3 -2 }):Play();
v1:Create(var_180.tog.check,TweenInfo.new(0.3 -0 ,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{ImageTransparency=0.3 -0 }):Play();
var_314=354 -351 ;
end
 if (var_314==0) then
 v1:Create(var_180.title,TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{TextTransparency=0}):Play();
v1:Create(var_180.tog,TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{BackgroundColor3=var_8.theme.Hitbox}):Play();
var_314=1;
end
 if (var_314==(1313 -1310)) then
 var_180.tog.check:TweenPosition(UDim2.new(0.5 + 0 ,299 -299 ,0.5 + 0 ,0 + 0 ),Enum.EasingDirection.Out,Enum.EasingStyle.Quad,0.5,true);
break;
end
 end
 else
 v1:Create(var_180.title,TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{TextTransparency=269.6 -269 }):Play();
v1:Create(var_180.tog,TweenInfo.new(0.5 + 0 ,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{BackgroundColor3=Color3.fromRGB(20,20 + 0 ,35 -15 )}):Play();
v1:Create(var_180.tog.check,TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{ImageTransparency=2 -1 }):Play();
v1:Create(var_180.tog.check.UIScale,TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{Scale=315.3 -315 }):Play();
var_180.tog.check:TweenPosition(UDim2.new(0.5 -0 ,0 + 0 ,0.5 + 0 ,5 + 5 ),Enum.EasingDirection.Out,Enum.EasingStyle.Quad,0.5 -0 ,true);
v1:Create(var_180.tog.gradfr,TweenInfo.new(0.4,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{BackgroundTransparency=1376 -1375 }):Play();
end
 SaveConfig();
end
;
if var_8.ConfigEnabled then
 if var_179.Flag then
 var_8.Flags[var_179.Flag]=var_179;
end
 end
 var_8.util.AddConnection(var_8.Comms.Event,function(v714,v715) if (v714=="Hitbox") then
 if var_179.Value then
 var_180.tog.BackgroundColor3=v715;
end
 end
 end
);
return var_179;
end
;
var_129.createSlider=function(v513,v514) local var_182={Title=v514.Title or "Slider" ,Sliders=v514.Sliders};
local var_183=var_17.page.L.section.Container.slider:Clone();
var_183.Visible=true;
var_183.Parent=var_130.Container;
var_183.title.Text=var_182.Title;
var_183.Name=var_182.Title;
var_183.slidelist.slideholder.Visible=false;
for v716,v717 in pairs(var_182.Sliders) do
 local var_235=var_17.page.L.section.Container.slider.slidelist.slideholder:Clone();
var_235.Visible=true;
var_235.Parent=var_183.slidelist;
var_235.sliderframe.suffix.Text=v717.title or var_235.sliderframe.suffix:Destroy() ;
print("Creating slider:",v717.title,"Index:",v716);
v717={title=v717.title or "slide" ,increment=v717.increment or 1 ,range=v717.range or {0 + 0 ,152 -52 } ,startvalue=v717.startvalue or 16 ,callback=v717.callback,Flag=v717.Flag};
local var_236={dragging=false};
local var_237;
if (v717.startvalue<=v717.range[2 -1 ]) then
 var_237=0;
elseif (v717.startvalue>=v717.range[2]) then
 var_237=1;
else
 local var_359=v717.range[1 + 1 ] -v717.range[1 -0 ] ;
var_237=(v717.startvalue-v717.range[1 + 0 ])/var_359 ;
end
 var_235.sliderframe.slide:TweenSize(UDim2.new(var_237,0,689 -689 ,1 + 4 ),Enum.EasingDirection.Out,Enum.EasingStyle.Quint,0.5,true);
var_8.util.registerLoadTween(var_235.sliderframe.slide,{Size=UDim2.new(var_237,0,0 -0 ,5)},{Size=UDim2.new(0,1588 -1488 ,1.1,0 -0 )},TweenInfo.new(0.7,Enum.EasingStyle.Quint,Enum.EasingDirection.Out));
var_235.sliderframe.value.Text="<font size= '14'>"   .. tostring(v717.startvalue)   .. "</font>"   .. "<font color='rgb(86, 86, 86)'>/"   .. v717.range[1 + 1 ]   .. "</font>" ;
local function v726(v859) if var_236.dragging then
 local var_339=0;
local var_340;
local var_341;
local var_342;
local var_343;
local var_344;
local var_345;
while true do
 if (var_339==0) then
 var_340=(v859-var_235.sliderframe.AbsolutePosition.X)/var_235.sliderframe.AbsoluteSize.X ;
var_340=math.clamp(var_340,0,1);
var_341=v717.range[5 -3 ] -v717.range[1] ;
var_339=1 + 0 ;
end
 if (var_339==4) then
 v717.startvalue=var_342;
SaveConfig();
break;
end
 if (var_339==1) then
 var_342=v717.range[1] + (var_340 * var_341) ;
var_343=var_3:GetTextSize(tostring(var_342)   .. "/"   .. v717.range[611 -609 ] ,14,Enum.Font.SourceSans,Vector2.new(math.huge,math.huge));
var_342=(math.floor(((var_342-v717.range[1])/v717.increment) + 0.5 ) * v717.increment) + v717.range[2 -1 ] ;
var_339=1964 -1962 ;
end
 if (var_339==2) then
 var_235.sliderframe.slide:TweenSize(UDim2.new(var_340,0,1755 -1755 ,3 + 2 ),Enum.EasingDirection.Out,Enum.EasingStyle.Quart,0.3 -0 ,true);
var_8.util.registerLoadTween(var_235.sliderframe.slide,{Size=UDim2.new(var_340,0,0,5)},{Size=UDim2.new(0,100,1.1,1405 -1405 )},TweenInfo.new(0.7,Enum.EasingStyle.Quint,Enum.EasingDirection.Out));
var_235.sliderframe.value.Text="<font size= '14'>"   .. tostring(var_342)   .. "</font>"   .. "<font color='rgb(86, 86, 86)'>/"   .. v717.range[2 + 0 ]   .. "</font>" ;
var_339=8 -5 ;
end
 if (var_339==3) then
 v1:Create(var_235.sliderframe.suffix,TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{TextTransparency=0}):Play();
var_344,var_345=pcall(function() v717.callback(var_342);
end
);
if  not var_344 then
 print("error in ["   .. var_235.Name   .. "], "   .. tostring(var_345) );
end
 var_339=4;
end
 end
 end
 end
 var_235.sliderframe.interact.MouseButton1Down:Connect(function(v860) var_236.dragging=true;
v726(v860);
end
);
var_235.sliderframe.interact.MouseButton1Up:Connect(function() var_236.dragging=false;
end
);
var_8.util.AddConnection(v4.InputEnded,function(v863,v864) if (v863.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
 var_236.dragging=false;
v1:Create(var_235.sliderframe.suffix,TweenInfo.new(302.3 -302 ,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{TextTransparency=0.64 + 0 }):Play();
v1:Create(var_235.sliderframe.value,TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{BackgroundTransparency=1 + 0 }):Play();
var_235.sliderframe.value:TweenPosition(UDim2.new(3 -2 ,0,1161 -1161 , -12),Enum.EasingDirection.Out,Enum.EasingStyle.Quint,0.2,true);
end
 end
);
var_8.util.AddConnection(v4.InputChanged,function(v865) if (var_236.dragging and (v865.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch)) then
 v726(v865.Position.X);
end
 end
);
var_235.sliderframe.slide.BackgroundColor3=var_8.theme.Hitbox;
var_183.slidelist.Size=UDim2.new(1 + 0 ,0 -0 ,358 -358 ,var_183.slidelist.UIListLayout.AbsoluteContentSize.Y);
var_183.Size=UDim2.new(898 -897 , -20,0 -0 ,var_183.slidelist.AbsoluteSize.Y + (170 -142) );
var_8.util.AddConnection(var_8.Comms.Event,function(v866,v867) if (v866=="Hitbox") then
 var_235.sliderframe.slide.BackgroundColor3=v867;
end
 end
);
v717.Set=function(v868,v869) local var_287=777 -777 ;
local var_288;
local var_289;
local var_290;
local var_291;
while true do
 if (1==var_287) then
 v1:Create(var_235.sliderframe.slide,TweenInfo.new(0.45,Enum.EasingStyle.Exponential,Enum.EasingDirection.Out),{Size=UDim2.new(var_289,0 + 0 ,0 -0 ,18 -13 )}):Play();
var_235.sliderframe.value.Text="<font size='14'>"   .. tostring(v869)   .. "</font><font color='rgb(86, 86, 86)'>/"   .. v717.range[2 + 0 ]   .. "</font>" ;
var_287=3 -1 ;
end
 if (var_287==2) then
 var_8.util.registerLoadTween(var_235.sliderframe.slide,{Size=UDim2.new(var_289,719 -719 ,0,4 + 1 )},{Size=UDim2.new(0 -0 ,37 + 63 ,2.1 -1 ,0)},TweenInfo.new(0.7,Enum.EasingStyle.Quint,Enum.EasingDirection.Out));
var_290,var_291=pcall(function() v717.callback(v869);
end
);
var_287=3;
end
 if (var_287==3) then
 if  not var_290 then
 warn("Error in slider callback: "   .. tostring(var_291) );
end
 v717.startvalue=v869;
var_287=4;
end
 if (4==var_287) then
 SaveConfig();
break;
end
 if (var_287==0) then
 var_288=v717.range[1 + 1 ] -v717.range[3 -2 ] ;
var_289=(v869-v717.range[4 -3 ])/var_288 ;
var_287=1;
end
 end
 end
;
if var_8.ConfigEnabled then
 if v717.Flag then
 var_8.Flags[v717.Flag]=v717;
end
 end
 end
 end
;
var_129.createDropdown=function(v524,v525) local var_184={Title=v525.Title or "dropdown" ,Options=v525.Options,CurrentOption=v525.CurrentOption,Placeholder=v525.Placeholder,Multi=v525.Multi,Callback=v525.Callback};
local var_185=var_17.page.L.section.Container.dropdown:Clone();
var_185.Visible=true;
var_185.Parent=var_130.Container;
var_185.title.Text=var_184.Title;
var_185.Name=var_184.Title;
var_185.containerF.container.option.Visible=false;
var_185.containerF.Visible=false;
var_185.containerF.Position=UDim2.new(1 -0 ,0,0 + 0 ,59 -29 );
var_185.dropframe.selected.Text=var_184.Placeholder or "..." ;
var_184.Placeholder=var_184.Placeholder or "..." ;
local var_186=var_8.theme.Accent;
local var_187=Color3.fromRGB(6 + 116 ,358 -236 ,139 -17 );
local var_188=false;
local var_189=false;
local var_190=var_185.containerF.container.option;
local var_191;
var_185.dropframe.interact.MouseButton1Click:Connect(function() if var_189 then
 return;
end
 if  not var_188 then
 var_188=true;
var_185.containerF.Visible=true;
v1:Create(var_185.containerF,TweenInfo.new(0.3 -0 ,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{BackgroundTransparency=0}):Play();
v1:Create(var_185.containerF.UIStroke,TweenInfo.new(0.2 -0 ,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{Transparency=0 -0 }):Play();
v1:Create(var_185.containerF.container,TweenInfo.new(0.3 -0 ,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{ScrollBarImageTransparency=0 + 0 }):Play();
for v986,v987 in ipairs(var_185.containerF.container:GetChildren()) do
 if v987:IsA("Frame") then
 v1:Create(v987.title,TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{TextTransparency=0}):Play();
end
 end
 var_185.containerF:TweenPosition(UDim2.new(1,1973 -1973 ,0 + 0 ,36),Enum.EasingDirection.Out,Enum.EasingStyle.Quad,0.3 + 0 ,true);
v1:Create(var_185.dropframe.arrow,TweenInfo.new(0.3 -0 ,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{Rotation=885 -705 }):Play();
else
 local var_315=354 -354 ;
while true do
 if (var_315==0) then
 var_188=false;
v1:Create(var_185.containerF,TweenInfo.new(1271.2 -1271 ,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{BackgroundTransparency=1 + 0 }):Play();
var_315=3 -2 ;
end
 if (var_315==1) then
 v1:Create(var_185.containerF.UIStroke,TweenInfo.new(0.2,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{Transparency=1 -0 }):Play();
v1:Create(var_185.containerF.container,TweenInfo.new(1696.2 -1696 ,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{ScrollBarImageTransparency=1}):Play();
var_315=2 -0 ;
end
 if (2==var_315) then
 for v1075,v1076 in ipairs(var_185.containerF.container:GetChildren()) do
 if v1076:IsA("Frame") then
 local var_384=0;
while true do
 if (var_384==0) then
 v1:Create(v1076.indicator,TweenInfo.new(0.2,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{BackgroundTransparency=1067 -1066 }):Play();
v1:Create(v1076.title,TweenInfo.new(0.2,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{TextTransparency=2 -1 }):Play();
break;
end
 end
 end
 end
 var_185.containerF:TweenPosition(UDim2.new(3 -2 ,388 -388 ,0,30),Enum.EasingDirection.Out,Enum.EasingStyle.Quad,905.3 -905 ,true);
var_315=8 -5 ;
end
 if (var_315==3) then
 v1:Create(var_185.dropframe.arrow,TweenInfo.new(0.3 -0 ,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{Rotation=1956 -1956 }):Play();
task.wait(0.2 -0 );
var_315=4;
end
 if (var_315==4) then
 var_185.containerF.Visible=false;
break;
end
 end
 end
 end
);
local var_192={};
local var_193=false;
local function v547() if (var_184.Options and ( #var_184.Options>(1901 -1901))) then
 local var_316=0;
while true do
 if (var_316==0) then
 for v1077,v1078 in ipairs(var_184.Options) do
 local var_382=var_190:Clone();
var_382.title.Text=v1078;
var_382.Parent=var_185.containerF.container;
var_382.Visible=true;
var_382.Name=v1078;
var_185.dropframe.interact.MouseButton1Click:Connect(function() if (var_188==false) then
 print("op");
if var_192[v1078] then
 v1:Create(var_382.indicator,TweenInfo.new(0.2 -0 ,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{BackgroundTransparency=0}):Play();
end
 end
 end
);
var_382.interact.MouseButton1Click:Connect(function() if var_184.Multi then
 if var_192[v1078] then
 local var_394=0;
while true do
 if (var_394==(773 -773)) then
 var_192[v1078]=nil;
v1:Create(var_382.title,TweenInfo.new(0.2,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{TextColor3=var_187}):Play();
var_394=1 -0 ;
end
 if (var_394==1) then
 v1:Create(var_382.indicator,TweenInfo.new(0.2 + 0 ,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{BackgroundColor3=var_187}):Play();
v1:Create(var_382.indicator,TweenInfo.new(0.2 -0 ,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{BackgroundTransparency=1}):Play();
var_394=1 + 1 ;
end
 if (var_394==2) then
 var_382.title:TweenPosition(UDim2.new(853 -853 ,10,1311 -1311 ,0 + 0 ),Enum.EasingDirection.Out,Enum.EasingStyle.Quad,0.2,true);
break;
end
 end
 else
 var_192[v1078]=true;
v1:Create(var_382.title,TweenInfo.new(0.2,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{TextColor3=var_186}):Play();
v1:Create(var_382.indicator,TweenInfo.new(895.2 -895 ,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{BackgroundColor3=var_186}):Play();
v1:Create(var_382.indicator,TweenInfo.new(0.2,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{BackgroundTransparency=0}):Play();
var_382.title:TweenPosition(UDim2.new(0 + 0 ,42 -27 ,0 -0 ,0),Enum.EasingDirection.Out,Enum.EasingStyle.Quad,0.2,true);
end
 local var_389={};
for v1113,v1114 in pairs(var_184.Options) do
 if var_192[v1114] then
 table.insert(var_389,v1114);
end
 end
 if ( #var_389==0) then
 var_185.dropframe.selected.Text=var_184.Placeholder;
else
 local var_395=table.concat(var_389,", ");
var_185.dropframe.selected.Text=var_395;
end
 if var_184.Callback then
 local var_396=0 -0 ;
local var_397;
while true do
 if (var_396==1) then
 var_184.Callback(var_397);
break;
end
 if (var_396==0) then
 var_397={};
for v1144,v1145 in ipairs(var_184.Options) do
 if var_192[v1145] then
 table.insert(var_397,v1145);
end
 end
 var_396=1;
end
 end
 end
 else
 var_185.dropframe.selected.Text=v1078;
for v1115,v1116 in pairs(var_185.containerF.container:GetChildren()) do
 if (v1116:IsA("Frame") and v1116.title) then
 v1:Create(v1116.title,TweenInfo.new(0.2,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{TextColor3=var_187}):Play();
v1:Create(v1116.indicator,TweenInfo.new(0.2,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{BackgroundColor3=var_187}):Play();
v1:Create(v1116.indicator,TweenInfo.new(0.2,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{BackgroundTransparency=802 -801 }):Play();
v1116.title:TweenPosition(UDim2.new(0,10,866 -866 ,0),Enum.EasingDirection.Out,Enum.EasingStyle.Quad,0.2 -0 ,true);
end
 end
 v1:Create(var_382.title,TweenInfo.new(0.2,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{TextColor3=var_186}):Play();
v1:Create(var_382.indicator,TweenInfo.new(0.2 -0 ,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{BackgroundColor3=var_186}):Play();
v1:Create(var_382.indicator,TweenInfo.new(0.2 -0 ,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{BackgroundTransparency=0 -0 }):Play();
var_382.title:TweenPosition(UDim2.new(0,2 + 13 ,0 -0 ,0 + 0 ),Enum.EasingDirection.Out,Enum.EasingStyle.Quad,0.2,true);
if var_184.Callback then
 var_184.Callback(v1078);
end
 var_188=false;
v1:Create(var_185.containerF,TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{BackgroundTransparency=1}):Play();
v1:Create(var_185.containerF.container,TweenInfo.new(0.3 -0 ,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{ScrollBarImageTransparency=1}):Play();
v1:Create(var_185.containerF.UIStroke,TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{Transparency=105 -104 }):Play();
for v1117,v1118 in ipairs(var_185.containerF.container:GetChildren()) do
 if v1118:IsA("Frame") then
 local var_398=0;
while true do
 if ((554 -554)==var_398) then
 v1:Create(v1118,TweenInfo.new(0.3 -0 ,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{BackgroundTransparency=3 -2 }):Play();
v1:Create(v1118.title,TweenInfo.new(0.3 + 0 ,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{TextTransparency=1}):Play();
break;
end
 end
 end
 end
 var_185.containerF:TweenPosition(UDim2.new(1 + 0 ,0,1503 -1503 ,87 -57 ),Enum.EasingDirection.Out,Enum.EasingStyle.Quad,1204.3 -1204 ,true);
v1:Create(var_185.dropframe.arrow,TweenInfo.new(0.3 + 0 ,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{Rotation=0 + 0 }):Play();
var_185:TweenSize(UDim2.new(320 -319 , -10,0 -0 ,35),Enum.EasingDirection.Out,Enum.EasingStyle.Quad,0.3 -0 ,true);
task.wait(0.2 -0 );
var_185.containerF.Visible=false;
return var_192;
end
 end
);
end
 if var_184.currentoption then
 var_185.dropframe.selected.Text=var_184.currentoption;
end
 break;
end
 end
 else
 var_185.dropframe.selected.Text="...";
end
 end
 v547();
var_184.Refresh=function(v732,v733) local var_238=0 -0 ;
while true do
 if (var_238==0) then
 var_184.Options=v733;
v547();
break;
end
 end
 end
;
var_185.containerF.container.ScrollBarImageColor3=var_8.theme.Accent;
var_8.util.AddConnection(var_8.Comms.Event,function(v735,v736) if (v735=="Accent") then
 var_185.containerF.container.ScrollBarImageColor3=v736;
var_186=v736;
end
 end
);
return var_184;
end
;
var_129.createColorpicker=function(v551,v552) local var_194={Title=v552.Title or "colorpicker" ,Color=v552.Color,Callback=v552.Callback,Flag=v552.Flag};
var_194.Type="ColorPicker";
local var_195=var_17.page.L.section.Container.colorpicker:Clone();
var_195.Visible=true;
var_195.Parent=var_130.Container;
var_195.title.Text=var_194.Title;
var_195.Name=var_194.Title;
local var_196=var_13.pickerconfig:Clone();
var_196.Parent=var_13.renders;
var_196.Visible=false;
local var_197=false;
local var_198=false;
local var_199=false;
var_195.container.SVPicker.BackgroundTransparency=1;
var_195.container.Hue.BackgroundTransparency=1;
if (var_199==false) then
 v1:Create(var_195.config,TweenInfo.new(139.7 -139 ,Enum.EasingStyle.Quart,Enum.EasingDirection.Out),{ImageTransparency=4 -3 }):Play();
v1:Create(var_195.config,TweenInfo.new(0.6,Enum.EasingStyle.Quart,Enum.EasingDirection.Out),{Position=UDim2.new(1, -20,0 + 0 ,5 + 10 )}):Play();
end
 var_195.MouseEnter:Connect(function() v1:Create(var_195.config,TweenInfo.new(0.6 -0 ,Enum.EasingStyle.Quart,Enum.EasingDirection.Out),{Position=UDim2.new(1 + 0 , -32,0,28 -13 )}):Play();
v1:Create(var_195.config,TweenInfo.new(0.7 + 0 ,Enum.EasingStyle.Quart,Enum.EasingDirection.Out),{ImageTransparency=0 + 0 }):Play();
end
);
var_195.MouseLeave:Connect(function() if (var_199==false) then
 local var_317=1751 -1751 ;
while true do
 if (var_317==(1940 -1940)) then
 v1:Create(var_195.config,TweenInfo.new(0.7,Enum.EasingStyle.Quart,Enum.EasingDirection.Out),{ImageTransparency=2 -1 }):Play();
v1:Create(var_195.config,TweenInfo.new(0.6 -0 ,Enum.EasingStyle.Quart,Enum.EasingDirection.Out),{Position=UDim2.new(1, -20,0 + 0 ,12 + 3 )}):Play();
break;
end
 end
 end
 end
);
local function v571() local var_239=0;
while true do
 if (var_239==1) then
 var_195:TweenSize(UDim2.new(1, -10,972 -972 ,120 + 50 ),Enum.EasingDirection.Out,Enum.EasingStyle.Quart,0.5,true);
wait(0.5 -0 );
var_239=2 + 0 ;
end
 if (var_239==3) then
 v1:Create(var_195.container.Hue,TweenInfo.new(0.4 + 0 ,Enum.EasingStyle.Quart,Enum.EasingDirection.Out),{BackgroundTransparency=0 + 0 }):Play();
var_198=false;
break;
end
 if (var_239==0) then
 var_197=true;
var_198=true;
var_239=1;
end
 if (var_239==(1303 -1301)) then
 var_195.container.Visible=true;
v1:Create(var_195.container.SVPicker,TweenInfo.new(697.4 -697 ,Enum.EasingStyle.Quart,Enum.EasingDirection.Out),{BackgroundTransparency=1543 -1543 }):Play();
var_239=3;
end
 end
 end
 local function v572() local var_240=0;
while true do
 if ((1890 -1887)==var_240) then
 var_195.container.Visible=false;
var_198=false;
break;
end
 if (var_240==(1712 -1710)) then
 var_195:TweenSize(UDim2.new(3 -2 , -10,95 -95 ,449 -421 ),Enum.EasingDirection.Out,Enum.EasingStyle.Quart,0.4 + 0 ,true);
wait(0.4);
var_240=3;
end
 if (var_240==0) then
 var_197=false;
var_198=true;
var_240=1;
end
 if (var_240==1) then
 v1:Create(var_195.container.SVPicker,TweenInfo.new(64.3 -64 ,Enum.EasingStyle.Quart,Enum.EasingDirection.Out),{BackgroundTransparency=1}):Play();
v1:Create(var_195.container.Hue,TweenInfo.new(0.3,Enum.EasingStyle.Quart,Enum.EasingDirection.Out),{BackgroundTransparency=4 -3 }):Play();
var_240=5 -3 ;
end
 end
 end
 var_195.setcolor.MouseButton1Click:Connect(function() if var_198 then
 return;
end
 if  not var_197 then
 var_197=true;
v571();
else
 local var_318=0 -0 ;
while true do
 if (var_318==0) then
 var_197=false;
v572();
break;
end
 end
 end
 end
);
local var_200;
if var_194.Color then
 var_200={var_194.Color:ToHSV()};
else
 var_200={408 -408 ,285 -285 ,0};
end
 local var_201=var_194.Color;
local var_202=var_200[1 + 0 ];
local function v576(v739) local var_241=0;
while true do
 if (var_241==0) then
 if (type(v739)~="table") then
 return v739;
end
 return Color3.fromHSV(v739[493 -492 ],v739[1 + 1 ],v739[9 -6 ]);
end
 end
 end
 local function v577(v741,v742,v743) v742=v742 or "RGB" ;
v743=v743 or (1088 -1086) ;
local var_242="";
if (v742=="RGB") then
 return math.round(v741.R * (558 -303) )   .. ","   .. math.round(v741.G * 255 )   .. ","   .. math.round(v741.B * 255 ) ;
elseif (v742=="Hex") then
 local var_360=1240 -1240 ;
while true do
 if (var_360==0) then
 var_242=string.format("#%02X%02X%02X",math.round(v741.R * 255 ),math.round(v741.G * (2225 -1970) ),math.round(v741.B * (1145 -890) ));
return var_242;
end
 end
 end
 end
 local var_203=var_195.container.SVPicker;
local var_204=var_195.container.Hue;
local function v580() local var_243=52 -52 ;
local var_244;
local var_245;
while true do
 if (4==var_243) then
 var_195.container.RGB.RGBBox.PlaceholderText=var_245;
if var_194.Callback then
 var_194.Callback(var_194.Color);
end
 break;
end
 if (var_243==2) then
 v1:Create(var_204.Pin,TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{Position=UDim2.new(1 -var_200[1126 -1125 ] ,0 + 0 ,605.5 -605 ,0 -0 )}):Play();
var_244=v577(var_194.Color,"Hex");
var_243=3;
end
 if (var_243==0) then
 var_194.Color=v576(var_200);
var_195.setcolor.BackgroundColor3=var_194.Color;
var_243=1 + 0 ;
end
 if (var_243==3) then
 var_195.container.HEX.HEXBox.PlaceholderText=var_244;
var_245=v577(var_194.Color,"RGB",1445 -1443 );
var_243=4;
end
 if (1==var_243) then
 var_203.BackgroundColor3=Color3.fromHSV(var_200[1359 -1358 ],1 + 0 ,1 + 0 );
v1:Create(var_203.Pin,TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{Position=UDim2.new(var_200[1 + 1 ],1645 -1645 ,1 -var_200[1507 -1504 ] ,0)}):Play();
var_243=2 + 0 ;
end
 end
 end
 v580();
local var_205,v582=nil,nil;
var_8.util.AddConnection(var_203.InputBegan,function(v748) if (v748.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
 var_205=v3.RenderStepped:Connect(function() local var_346=var_203.AbsolutePosition;
local var_347=game.Players.LocalPlayer:GetMouse();
local var_348=var_203.AbsoluteSize;
local var_349=math.clamp(var_347.X-var_203.AbsolutePosition.X ,0 + 0 ,var_203.AbsoluteSize.X)/var_203.AbsoluteSize.X ;
var_203.Pin:TweenSize(UDim2.new(0 + 0 ,25,0 -0 ,22 + 3 ),Enum.EasingDirection.Out,Enum.EasingStyle.Quart,0.5 + 0 ,true);
local var_350=math.clamp(var_347.Y-(var_203.AbsolutePosition.Y + 0) ,182 -182 ,var_203.AbsoluteSize.Y)/var_203.AbsoluteSize.Y ;
var_200[2]=var_349;
var_200[3]=1 -var_350 ;
v580();
end
);
end
 end
);
var_8.util.AddConnection(var_203.InputEnded,function(v749) if (v749.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
 if var_205 then
 local var_361=0;
while true do
 if (var_361==1) then
 SaveConfig();
break;
end
 if (var_361==0) then
 var_203.Pin:TweenSize(UDim2.new(0 -0 ,174 -164 ,960 -960 ,10),Enum.EasingDirection.Out,Enum.EasingStyle.Quint,0.3,true);
var_205:Disconnect();
var_361=118 -117 ;
end
 end
 end
 end
 end
);
var_8.util.AddConnection(var_204.InputBegan,function(v750) if (v750.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
 v582=v3.RenderStepped:Connect(function() local var_351=game.Players.LocalPlayer:GetMouse();
var_204.Pin:TweenSize(UDim2.new(482 -482 ,23,0 -0 ,23),Enum.EasingDirection.Out,Enum.EasingStyle.Quart,0.5,true);
local var_352=math.clamp(var_351.X-var_204.AbsolutePosition.X ,0,var_204.AbsoluteSize.X)/var_204.AbsoluteSize.X ;
var_200[2 -1 ]=1 -var_352 ;
v580();
end
);
end
 end
);
var_8.util.AddConnection(var_204.InputEnded,function(v751) if (v751.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
 if v582 then
 var_204.Pin:TweenSize(UDim2.new(0 + 0 ,10,0 + 0 ,3 + 7 ),Enum.EasingDirection.Out,Enum.EasingStyle.Quint,0.3,true);
v582:Disconnect();
SaveConfig();
end
 end
 end
);
var_195.container.HEX.HEXBox.FocusLost:Connect(function(v752) local var_246=0 + 0 ;
local var_247;
local var_248;
local var_249;
while true do
 if (var_246==0) then
 if  not v752 then
 return;
end
 var_247=var_195.container.HEX.HEXBox.Text;
var_246=1;
end
 if (var_246==1) then
 var_248,var_249=pcall(function() return Color3.fromHex(var_247);
end
);
if var_248 then
 local var_377,v1057,v1058=var_249:ToHSV();
var_195.container.HEX.HEXBox.Text="";
var_195.container.RGB.RGBBox.Text="";
var_200[1 + 0 ]=var_377;
var_200[6 -4 ]=v1057;
var_200[1 + 2 ]=v1058;
v580();
else
 warn("Failed to convert hex to color:",var_249);
end
 break;
end
 end
 end
);
var_195.container.RGB.RGBBox.FocusLost:Connect(function(v757) local var_250=51 -51 ;
local var_251;
local var_252;
local var_253;
local var_254;
while true do
 if (0==var_250) then
 if  not v757 then
 return;
end
 var_251=var_195.container.RGB.RGBBox.Text;
var_250=1 + 0 ;
end
 if (var_250==1) then
 var_252,var_253,var_254=var_251:match("^(%d+),%s*(%d+),%s*(%d+)$");
if (var_252 and var_253 and var_254) then
 local var_378=0;
while true do
 if (var_378==0) then
 var_252,var_253,var_254=tonumber(var_252),tonumber(var_253),tonumber(var_254);
if ((var_252>=0) and (var_252<=255) and (var_253>=0) and (var_253<=255) and (var_254>=0) and (var_254<=255)) then
 local var_390=Color3.fromRGB(var_252,var_253,var_254);
local var_391,v1121,v1122=var_390:ToHSV();
var_200[1 + 0 ]=var_391;
var_200[2]=v1121;
var_200[3]=v1122;
var_195.container.HEX.HEXBox.Text="";
var_195.container.RGB.RGBBox.Text="";
v580();
else
 warn("RGB values must be between 0 and 255.");
end
 break;
end
 end
 else
 warn("Invalid RGB format. Please use the format 'R,G,B' (e.g., 16,16,16).");
end
 break;
end
 end
 end
);
local var_206=0.005;
local function v584() local var_255=0 -0 ;
while true do
 if ((1711 -1710)==var_255) then
 v580();
break;
end
 if (var_255==0) then
 var_202=(var_202 + var_206)%1 ;
var_200[714 -713 ]=var_202;
var_255=1439 -1438 ;
end
 end
 end
 local var_207=false;
local var_208=nil;
local function v587() var_207= not var_207;
if var_207 then
 if  not var_208 then
 var_208=v3.RenderStepped:Connect(v584);
v1:Create(var_195.container.Rainbow.Tick,TweenInfo.new(0.3 -0 ,Enum.EasingStyle.Quart,Enum.EasingDirection.Out),{BackgroundColor3=var_8.theme.Hitbox}):Play();
end
 elseif var_208 then
 local var_362=0 + 0 ;
while true do
 if (var_362==1) then
 var_208=nil;
break;
end
 if (var_362==0) then
 var_208:Disconnect();
v1:Create(var_195.container.Rainbow.Tick,TweenInfo.new(392.3 -392 ,Enum.EasingStyle.Quart,Enum.EasingDirection.Out),{BackgroundColor3=Color3.fromRGB(30,25 + 5 ,14 + 16 )}):Play();
var_362=1;
end
 end
 end
 end
 var_195.container.Rainbow.MouseButton1Click:Connect(v587);
var_195.config.MouseEnter:Connect(function() v1:Create(var_195.config,TweenInfo.new(0.2,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{ImageColor3=Color3.fromRGB(755 -500 ,255,255)}):Play();
v1:Create(var_195.config,TweenInfo.new(0.2,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{ImageTransparency=0 + 0 }):Play();
end
);
var_195.config.MouseLeave:Connect(function() local var_256=0;
while true do
 if (var_256==0) then
 v1:Create(var_195.config,TweenInfo.new(0.2 -0 ,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{ImageColor3=Color3.fromRGB(783 -720 ,623 -560 ,200 -137 )}):Play();
v1:Create(var_195.config,TweenInfo.new(628.2 -628 ,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{ImageTransparency=0.61}):Play();
break;
end
 end
 end
);
local function v588() var_196.Visible=true;
var_199=true;
v1:Create(var_196,TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{BackgroundTransparency=253 -253 }):Play();
v1:Create(var_196.Copy.TextLabel,TweenInfo.new(0.3 + 0 ,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{TextTransparency=0.78 + 0 }):Play();
v1:Create(var_196.UIStroke,TweenInfo.new(0.3 -0 ,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{Transparency=0}):Play();
v1:Create(var_196.UIScale,TweenInfo.new(0.3 -0 ,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{Scale=1 + 0 }):Play();
end
 local function v589() local var_257=0 + 0 ;
while true do
 if (var_257==(796 -794)) then
 v1:Create(var_196.UIScale,TweenInfo.new(0.3 + 0 ,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{Scale=0.5 -0 }):Play();
task.wait(0.3 -0 );
var_257=3;
end
 if (var_257==(1970 -1970)) then
 var_199=false;
v1:Create(var_196,TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{BackgroundTransparency=1 -0 }):Play();
var_257=1 + 0 ;
end
 if (var_257==(367 -364)) then
 var_196.Visible=false;
var_196:TweenPosition(UDim2.new(0 -0 ,0 -0 ,620 -620 ,0 + 0 ),Enum.EasingDirection.Out,Enum.EasingStyle.Quad,0.1 -0 ,true);
break;
end
 if (var_257==1) then
 v1:Create(var_196.Copy.TextLabel,TweenInfo.new(1664.3 -1664 ,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{TextTransparency=1}):Play();
v1:Create(var_196.UIStroke,TweenInfo.new(492.3 -492 ,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{Transparency=444 -443 }):Play();
var_257=4 -2 ;
end
 end
 end
 local var_209;
local var_210=false;
local function v592() if var_210 then
 return;
end
 var_210=true;
if  not var_196.Visible then
 local var_319=0;
while true do
 if (var_319==(1007 -1007)) then
 var_209=v3.RenderStepped:Connect(function() var_196:TweenPosition(UDim2.new(0 -0 ,var_195.config.AbsolutePosition.X,458 -458 ,var_195.config.AbsolutePosition.Y + var_195.config.AbsoluteSize.Y + 65 ),Enum.EasingDirection.Out,Enum.EasingStyle.Quad,0.1 -0 ,true);
if  not var_196.Visible then
 var_209:Disconnect();
end
 end
);
v588();
break;
end
 end
 else
 local var_320=1911 -1911 ;
while true do
 if (var_320==0) then
 if var_209 then
 var_209:Disconnect();
end
 v589();
break;
end
 end
 end
 task.delay(0.4 + 0 ,function() var_210=false;
end
);
end
 var_195.config.MouseButton1Click:Connect(function() v592();
end
);
var_196.Selection.HEX.MouseEnter:Connect(function() v1:Create(var_196.Selection.HEX,TweenInfo.new(0.4 -0 ,Enum.EasingStyle.Quart,Enum.EasingDirection.Out),{BackgroundTransparency=1817.7 -1817 }):Play();
end
);
var_196.Selection.HEX.MouseLeave:Connect(function() v1:Create(var_196.Selection.HEX,TweenInfo.new(0.4 + 0 ,Enum.EasingStyle.Quart,Enum.EasingDirection.Out),{BackgroundTransparency=0.85}):Play();
end
);
var_196.Selection.RGB.MouseEnter:Connect(function() v1:Create(var_196.Selection.RGB,TweenInfo.new(0.4,Enum.EasingStyle.Quart,Enum.EasingDirection.Out),{BackgroundTransparency=144.7 -144 }):Play();
end
);
var_196.Selection.RGB.MouseLeave:Connect(function() v1:Create(var_196.Selection.RGB,TweenInfo.new(0.4,Enum.EasingStyle.Quart,Enum.EasingDirection.Out),{BackgroundTransparency=1844.85 -1844 }):Play();
end
);
local var_211=1;
local var_212=false;
var_196.Selection.HEX.interact.MouseButton1Click:Connect(function() if var_212 then
 return;
end
 var_212=true;
if var_194.Color then
 local var_321=v577(var_194.Color,"Hex");
setclipboard(var_321);
print("Color copied to clipboard:",var_321);
v1:Create(var_196.Selection.HEX.TextLabel,TweenInfo.new(1270.5 -1270 ,Enum.EasingStyle.Quart,Enum.EasingDirection.Out),{TextTransparency=157 -156 }):Play();
v1:Create(var_196.Selection.HEX.ImageLabel,TweenInfo.new(0.5 -0 ,Enum.EasingStyle.Quart,Enum.EasingDirection.Out),{ImageTransparency=1102 -1102 }):Play();
task.wait(350 -348 );
v1:Create(var_196.Selection.HEX.TextLabel,TweenInfo.new(0.5 -0 ,Enum.EasingStyle.Quart,Enum.EasingDirection.Out),{TextTransparency=0}):Play();
v1:Create(var_196.Selection.HEX.ImageLabel,TweenInfo.new(0.5 + 0 ,Enum.EasingStyle.Quart,Enum.EasingDirection.Out),{ImageTransparency=1 + 0 }):Play();
end
 task.wait(var_211);
var_212=false;
end
);
var_196.Selection.RGB.interact.MouseButton1Click:Connect(function() if var_212 then
 return;
end
 var_212=true;
if var_194.Color then
 local var_322=1604 -1604 ;
local var_323;
while true do
 if (var_322==2) then
 v1:Create(var_196.Selection.RGB.ImageLabel,TweenInfo.new(1082.5 -1082 ,Enum.EasingStyle.Quart,Enum.EasingDirection.Out),{ImageTransparency=0}):Play();
task.wait(7 -5 );
var_322=2 + 1 ;
end
 if ((1058 -1055)==var_322) then
 v1:Create(var_196.Selection.RGB.TextLabel,TweenInfo.new(0.5 + 0 ,Enum.EasingStyle.Quart,Enum.EasingDirection.Out),{TextTransparency=644 -644 }):Play();
v1:Create(var_196.Selection.RGB.ImageLabel,TweenInfo.new(725.5 -725 ,Enum.EasingStyle.Quart,Enum.EasingDirection.Out),{ImageTransparency=1}):Play();
break;
end
 if (1==var_322) then
 print("Color copied to clipboard:",var_323);
v1:Create(var_196.Selection.RGB.TextLabel,TweenInfo.new(0.5 -0 ,Enum.EasingStyle.Quart,Enum.EasingDirection.Out),{TextTransparency=819 -818 }):Play();
var_322=1499 -1497 ;
end
 if (var_322==0) then
 var_323=var_195.container.RGB.RGBBox.PlaceholderText;
setclipboard(var_323);
var_322=1;
end
 end
 end
 task.wait(var_211);
var_212=false;
end
);
if var_8.ConfigEnabled then
 if var_194.Flag then
 var_8.Flags[var_194.Flag]=var_194;
end
 end
 var_194.Set=function(v767,v768) var_194.Color=v768;
local var_258,v771,v772=v768:ToHSV();
var_200[1898 -1897 ],var_200[5 -3 ],var_200[7 -4 ]=var_258,v771,v772;
v580();
SaveConfig();
end
;
return var_194;
end
;
var_129.createTextInput=function(v596,v597) local var_213={Title=v597.Title or "Textinput" ,Placeholder=v597.Placeholder or "Discord T0ken here." ,Clearonlost=v597.Clearonlost or false ,Callback=v597.Callback};
local var_214=var_17.page.L.section.Container.textinput:Clone();
var_214.Visible=true;
var_214.Parent=var_130.Container;
var_214.title.Text=var_213.Title;
var_214.Name=var_213.Title;
var_214.inputbox.TextLabel.Text=var_213.Placeholder;
var_214.inputbox.TextLabel.BackgroundColor3=Color3.fromRGB(913 -796 ,117,15 + 102 );
var_214.title.Size=UDim2.new(1761 -1761 ,var_214.title.TextBounds.X,1668 -1667 ,0 -0 );
local var_215=var_214.inputbox;
local var_216= -var_214.title.TextBounds.X-18 ;
local var_217=var_216-var_215.Size.X.Offset ;
v1:Create(var_215,TweenInfo.new(0.7 -0 ,Enum.EasingStyle.Quint,Enum.EasingDirection.Out),{Size=UDim2.new(var_215.Size.X.Scale,var_216,var_215.Size.Y.Scale,var_215.Size.Y.Offset)}):Play();
var_8.util.registerLoadTween(var_215,{Size=UDim2.new(var_215.Size.X.Scale,var_216,var_215.Size.Y.Scale,var_215.Size.Y.Offset)},{Size=UDim2.new(1, -54,1068 -1068 ,26)},TweenInfo.new(0.7 + 0 ,Enum.EasingStyle.Quint,Enum.EasingDirection.Out));
v1:Create(var_215,TweenInfo.new(0.7,Enum.EasingStyle.Quint,Enum.EasingDirection.Out),{Position=var_215.Position-UDim2.new(0 + 0 ,var_217,0 + 0 ,0) }):Play();
var_8.util.registerLoadTween(var_215,{Position=var_215.Position-UDim2.new(0 -0 ,var_217,0,1766 -1766 ) },{Position=UDim2.new(1870 -1870 ,96 -41 ,0.567,0 + 0 )},TweenInfo.new(0.7 + 0 ,Enum.EasingStyle.Quint,Enum.EasingDirection.Out));
var_214.inputbox.TextBox.FocusLost:Connect(function(v776) if  not v776 then
 return;
end
 local var_259,v778=pcall(function() var_213.Callback(var_214.inputbox.TextBox.Text);
end
);
if var_213.Clearonlost then
 var_214.inputbox.TextBox.Text="";
end
 if  not var_259 then
 print("error ["   .. var_214.Name   .. "], "   .. tostring(v778) );
end
 end
);
var_214.inputbox.submit.MouseButton1Click:Connect(function() local var_260,v780=pcall(function() var_213.Callback(var_214.inputbox.TextBox.Text);
end
);
if var_213.Clearonlost then
 var_214.inputbox.TextBox.Text="";
end
 if  not var_260 then
 print("error ["   .. var_214.Name   .. "], "   .. tostring(v780) );
end
 end
);
var_214.inputbox.submit.MouseEnter:Connect(function() v1:Create(var_214.inputbox.submit.load,TweenInfo.new(0.4,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{ImageTransparency=0 -0 }):Play();
end
);
var_214.inputbox.submit.MouseLeave:Connect(function() v1:Create(var_214.inputbox.submit.load,TweenInfo.new(0.4 + 0 ,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{ImageTransparency=0.7 -0 }):Play();
end
);
local var_215=var_214.inputbox;
local var_218=var_215:WaitForChild("TextBox");
local var_219=var_215:WaitForChild("ImageLabel");
local var_220=var_215:WaitForChild("TextLabel");
var_219.Visible=false;
var_219.AnchorPoint=Vector2.new(0 -0 ,0.5);
var_220.AnchorPoint=Vector2.new(0,0.5);
var_220.Position=UDim2.new(591 -591 ,0,0.5,0 + 0 );
local function v620() local var_261=1419 -1419 ;
local var_262;
local var_263;
local var_264;
local var_265;
local var_266;
local var_267;
local var_268;
while true do
 if (var_261==0) then
 var_262=var_218.CursorPosition-1 ;
if (var_262<(638 -638)) then
 var_262=0;
end
 var_263=string.sub(var_218.Text,1 + 0 ,var_262);
var_261=1 + 0 ;
end
 if (var_261==3) then
 var_220.Text=var_218.Text;
var_220.Position=UDim2.new(0,0 + 0 ,0.5 -0 ,0 -0 );
break;
end
 if (var_261==(1496 -1494)) then
 var_267=TweenInfo.new(0.2,Enum.EasingStyle.Sine,Enum.EasingDirection.Out);
var_268=v1:Create(var_219,var_267,{Position=var_266});
var_268:Play();
var_261=11 -8 ;
end
 if (var_261==1) then
 var_264=var_3:GetTextSize(var_263,var_218.TextSize,var_218.Font,Vector2.new(math.huge,var_218.AbsoluteSize.Y));
var_265=math.min(var_264.X,var_218.AbsoluteSize.X-1 );
var_266=UDim2.new(0,var_265 + 11 ,683.5 -683 ,0 + 0 );
var_261=2 + 0 ;
end
 end
 end
 var_218:GetPropertyChangedSignal("Text"):Connect(v620);
var_218:GetPropertyChangedSignal("CursorPosition"):Connect(v620);
var_218.Focused:Connect(function() var_219.Visible=true;
v1:Create(var_219,TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{BackgroundTransparency=564 -564 }):Play();
v1:Create(var_220,TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{TextColor3=Color3.fromRGB(255,255,513 -258 )}):Play();
v620();
end
);
var_218.FocusLost:Connect(function() v1:Create(var_219,TweenInfo.new(36.3 -36 ,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{BackgroundTransparency=1 -0 }):Play();
v1:Create(var_220,TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{TextColor3=Color3.fromRGB(168 -51 ,212 -95 ,1205 -1088 )}):Play();
var_220.Text=var_213.Placeholder;
task.wait(0.3 -0 );
var_219.Visible=false;
end
);
v4.InputBegan:Connect(function(v793) if ((v793.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) and var_218:IsFocused()) then
 wait();
v620();
end
 end
);
var_218.Changed:Connect(function(v794) if ((v794=="Text") or (v794=="CursorPosition")) then
 v620();
end
 end
);
end
;
var_8.LoadSaveConfig=function() local var_221=0 + 0 ;
local var_222;
local var_223;
while true do
 if (var_221==1) then
 if var_8.ConfigEnabled then
 local var_363=1441 -1441 ;
local var_364;
local var_365;
while true do
 if (var_363==0) then
 var_364,var_365=pcall(function() local var_385=0 + 0 ;
local var_386;
while true do
 if (var_385==(241 -241)) then
 var_386=string.format("%s/%s/%s%s",var_8.ConfigFolder,"configs",var_8.ConfigFile,var_8.Ext);
if (isfile and isfile(var_386)) then
 var_223=LoadConfig(readfile(var_386));
end
 break;
end
 end
 end
);
if var_364 then
 var_8({Title="Loaded Save File",Content="Configuration loaded successfully from Save File.",Duration=3,Type="Success"});
print("Configuration loaded successfully from a previous session.");
elseif  not var_364 then
 warn("CC Configurations Error | "   .. tostring(var_365) );
end
 break;
end
 end
 end
 break;
end
 if (var_221==0) then
 var_222=false;
var_223=false;
var_221=2 -1 ;
end
 end
 end
;
return var_129;
end
;
return var_85;
end
;
return var_32;
end
;
return var_8;
