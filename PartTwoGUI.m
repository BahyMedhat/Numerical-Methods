function varargout = PartTwoGUI(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @PartTwoGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @PartTwoGUI_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end

function PartTwoGUI_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
guidata(hObject, handles);

function varargout = PartTwoGUI_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;

function edit1_Callback(hObject, eventdata, handles)

function edit1_CreateFcn(hObject, eventdata, handles)


if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function InterpolateButton_Callback(hObject, eventdata, handles)
    data = get(handles.table, 'data');
    x= data(:,1);
    y= data(:,2);
    tic;
    f=Newton_Interpolation(x',y');
    time = num2str(toc*1000);
    set(handles.NewtonTime , 'string' , time);
    axes(handles.axes1);
    fplot(f,[min(x)-2 , max(x)+2],'b');
    hold on ;
    plot(x,y,'g.','MarkerSize',20);
     title('Newton Interpolation');
    hold off;
    set(handles.NewtonResult,'string',char(f));
    tic;
    u=Lagrange(x,y);
    time = num2str(toc*1000);
    set(handles.LagrangeTime , 'string' , time); 
    axes(handles.axes2);
    fplot(u,[min(x)-2 , max(x)+2],'k');
    hold on ;
    plot(x,y,'r.','MarkerSize',20);
     title('Lagrange Interpolation');
    hold off;
    set(handles.LagrangeResult,'string',char(u));

function axes1_CreateFcn(hObject, eventdata, handles)

function axes2_CreateFcn(hObject, eventdata, handles)

function numOfPoint_Callback(hObject, eventdata, handles)
str = get(hObject,'String');
n = str2double(str);
set(handles.table,'Data',zeros(n,2));
sz = size(get(handles.table,'Data'));
 sz(1,1) = 1;
set(handles.table,'ColumnEditable',true(sz));

function numOfPoint_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




function x_input_Callback(hObject, eventdata, handles)
    x =str2double(get(hObject,'String'));
    y=inline(get(handles.NewtonResult,'string'));
    axes(handles.axes1);
    st = num2str(y(x));
    str = 'Newton :y = ';
    str = [ str st];
    set(handles.Newton_y,'string',str);
    hold on ;
    plot(x,y(x),'r*','MarkerSize',10);
    hold off;
    y=inline(get(handles.LagrangeResult,'string'));
    axes(handles.axes2);
    st = num2str(y(x));
    str = 'Lagrange y = ';
    str = [ str st];
    set(handles.Lagrange_y,'string',str);
    hold on ;
    plot(x,y(x),'g*','MarkerSize',10);
    hold off;

function x_input_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function table_CellEditCallback(hObject, eventdata, handles)


function FileButton_Callback(hObject, eventdata, handles)
[FileName,PathName] = uigetfile('*.txt','Select the file');
file = fopen([PathName FileName]);
tmp = fscanf(file,'%f');
set(handles.numOfPoint,'string',tmp(1));
j = 1;
i = 2;
table = zeros(tmp(1),2);
while j <= tmp(1)
    table(j , 1) = tmp(i);
    table(j,2) = tmp(i+1);
    j = j+1;
    i = i+2;
end
set(handles.table,'Data',table);
fclose(file);
    


function NewtonTime_Callback(hObject, eventdata, handles)
function NewtonTime_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function LagrangeTime_Callback(hObject, eventdata, handles)
function LagrangeTime_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function NewtonResult_Callback(hObject, eventdata, handles)
function NewtonResult_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function LagrangeResult_Callback(hObject, eventdata, handles)
function LagrangeResult_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
