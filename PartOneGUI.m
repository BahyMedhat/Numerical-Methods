function varargout = PartOneGUI(varargin)

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @PartOneGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @PartOneGUI_OutputFcn, ...
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



function PartOneGUI_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
guidata(hObject, handles);


function varargout = PartOneGUI_OutputFcn(hObject, eventdata, handles) 

varargout{1} = handles.output;



function solveButton_Callback(hObject, eventdata, handles)
    
    axes(handles.axes1);

    func = get(handles.functionText , 'string');
    per = str2double(get(handles.percisionText , 'string'));
    max_it = str2num(get(handles.maxIteratonText , 'string'));
    x_lower = str2num(get(handles.xLowerText, 'string'));
    x_upper = str2num(get(handles.xUpperText , 'string'));
    true = 1;
    
    if(per < 0)
        true = 0;
        errordlg('Invalid Precision');
    end
    
    if (max_it < 1  && true)
        true = 0;
        errordlg('Invalid Max Iterations');
    end
    
    if(get(handles.False,'Value') == 1 && true)
  
        [xu, xl, xr, errors, time , divisionByZero, invalidGuesses] = false_position(func, x_upper,  x_lower, max_it, per);
        
         set(handles.rootText,'string',xr(1,numel(xr)));
         set(handles.TimeText,'string',[num2str(time) ' ms']);
         set(handles.table,'Data',getTableForFalseAndBisection(xu , xl , xr , errors)); 
         
         fplot(inline(func) , [x_lower, x_upper ]);
         hold on;
         title('F(x) Between x_lower and x_upper');
         plot(xr(1,numel(xr)),0,'r*');
         y = ylim();
         x = xlim();
         line([x(1) x(2)],[0 0] , 'color','k','linewidth',1.5);
         line([0 0], [y(1) y(2)] , 'color','k','linewidth',1.5);
         hold off;
         
        if(invalidGuesses)
            errordlg('Invalid Guesses ( > 0)');
        end
        
        if(divisionByZero)
            errordlg('division By Zero');
        end
         
    end
    
    if(get(handles.Fixed,'Value') == 1 && true)
      
        [ xr ,errors, time , done ] = fixed_point( func,max_it,per,x_lower);
      
        set(handles.rootText,'string',xr(1,numel(xr)));
        set(handles.TimeText,'string',[num2str(time) ' ms']);
        set(handles.table,'Data',getTable(xr , errors)); 
        
        func = strcat(func,'+x');
        fplot(inline(func) , [-25, 25]);
        hold on;
        title('y = g(x) and y = x between -25 and 25');
        fplot(inline('x') , [-25, 25] , 'r');
        legend('y = g(x)','y = x');
        plot(xr(1,numel(xr)),0,'r*');
        y = ylim();
        x = xlim();
        line([x(1) x(2)],[0 0] , 'color','k','linewidth',1.5);
        line([0 0], [y(1) y(2)] , 'color','k','linewidth',1.5);
        hold off;
        
        if(done == 0)
            errordlg('The Method Diverge');
        end
         
    end
    
     if(get(handles.Bisection,'Value') == 1 && true)
  
        [xu, xl, xr, errors, time , invalidGuesses] = Bisection(func, x_upper,  x_lower, max_it, per);
        
         set(handles.rootText,'string',xr(1,numel(xr)));
         set(handles.TimeText,'string',[num2str(time) ' ms']);
         set(handles.table,'Data',getTableForFalseAndBisection(xu , xl , xr , errors)); 
         
         fplot(inline(func) , [x_lower, x_upper ]);
         hold on;
         title('F(x) Between x_lower and x_upper');
         plot(xr(1,numel(xr)),0,'r*');
         y = ylim();
         x = xlim();
         line([x(1) x(2)],[0 0] , 'color','k','linewidth',1.5);
         line([0 0], [y(1) y(2)] , 'color','k','linewidth',1.5);
         hold off;
            
         
        if(invalidGuesses)
            errordlg('Invalid Guesses ( > 0)');
        end
      
     end
    
    
     if(get(handles.Birge,'Value') == 1 && true)
      
        [ xr ,errors, time ,divisionByZero, done ] = BirgeVieta(func,max_it,per,x_lower);
        
        set(handles.rootText,'string',xr(1,numel(xr)));
        set(handles.TimeText,'string',[num2str(time) ' ms']);
        set(handles.table,'Data',getTable(xr , errors)); 
        
        fplot(inline(func) , [-25, 25]);
        hold on;
        title('F(x) Between -25 and 25');
        plot(xr(1,numel(xr)),0,'r*');
        y = ylim();
        x = xlim();
        line([x(1) x(2)],[0 0] , 'color','k','linewidth',1.5);
        line([0 0], [y(1) y(2)] , 'color','k','linewidth',1.5);
        hold off;
        
        if(done == 0)
            errordlg('The Method Diverge');
        end
        
        if(divisionByZero)
            errordlg('division By Zero');
        end
         
    end
    
    if(get(handles.Newton,'Value') == 1 && true)
      
        [ xr ,errors, time ,divisionByZero, done ] = Newton( func,max_it,per,x_lower);
        
        set(handles.rootText,'string',xr(1,numel(xr)));
        set(handles.TimeText,'string',[num2str(time) ' ms']);
        set(handles.table,'Data',getTable(xr , errors)); 
        
        dfunc = diff(sym(func),1);
        fplot(inline(dfunc) , [-25, 25]);
        hold on;
        title('F\prime(x) Between -25 and 25');
        plot(xr(1,numel(xr)),0,'r*');
        y = ylim();
        x = xlim();
        line([x(1) x(2)],[0 0] , 'color','k','linewidth',1.5);
        line([0 0], [y(1) y(2)] , 'color','k','linewidth',1.5);
        hold off;
        
        if(done == 0)
            errordlg('The Method Diverge');
        end
        
        if(divisionByZero)
            errordlg('division By Zero');
        end
         
    end

    if(get(handles.Secant,'Value') == 1 && true)
      
        [ xr ,errors, time ,divisionByZero, done ] = Secant( func, max_it, per, x_lower, x_upper);
        
        set(handles.rootText,'string',xr(1,numel(xr)));
        set(handles.TimeText,'string',[num2str(time) ' ms']);
        set(handles.table,'Data',getTable(xr , errors)); 
        dfunc = diff(sym(func),1);
        fplot(inline(dfunc) , [-25, 25]);
        hold on;
        title('F(x) Between -25 and 25');
        plot(xr(1,numel(xr)),0,'r*');
        y = ylim();
        x = xlim();
        line([x(1) x(2)],[0 0] , 'color','k','linewidth',1.5);
        line([0 0], [y(1) y(2)] , 'color','k','linewidth',1.5);
        hold off;
        
        if(done == 0)
            errordlg('The Method Diverge');
        end
        
        if(divisionByZero)
            errordlg('division By Zero');
        end
         
    end
    
    
    if(get(handles.General,'Value') == 1 && true)
      
       [xu, xl, xr, errors, time] = general( func,x_lower, x_upper, per, max_it);
      
        set(handles.rootText,'string',xr(1,numel(xr)));
        set(handles.TimeText,'string',[num2str(time) ' ms']);
        set(handles.table,'Data',getTableForFalseAndBisection(xl , xu , xr , errors)); 
        fplot(inline(func) , [x_lower, x_upper]);
        hold on;
        title('F(x) between -25 and 25');
        plot(xr(1,numel(xr)),0,'r*');
        y = ylim();
        x = xlim();
        line([x(1) x(2)],[0 0] , 'color','k','linewidth',1.5);
        line([0 0], [y(1) y(2)] , 'color','k','linewidth',1.5);
        hold off;
       
    end



function False_Callback(hObject, eventdata, handles)
function Bisection_Callback(hObject, eventdata, handles)
function Fixed_Callback(hObject, eventdata, handles)
function Newton_Callback(hObject, eventdata, handles)
function Secant_Callback(hObject, eventdata, handles)
function Birge_Callback(hObject, eventdata, handles)
function General_Callback(hObject, eventdata, handles)


function rootText_Callback(hObject, eventdata, handles)
function rootText_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function TimeText_Callback(hObject, eventdata, handles)
function TimeText_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function percisionText_Callback(hObject, eventdata, handles)
function percisionText_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function maxIteratonText_Callback(hObject, eventdata, handles)
function maxIteratonText_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function functionText_Callback(hObject, eventdata, handles)
function functionText_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function fileButton_Callback(hObject, eventdata, handles)
[FileName,PathName] = uigetfile('*.txt','Select the file');
file = fopen([PathName FileName]);
firstline = fgets(file);
set(handles.functionText,'string',firstline);

function xUpperText_Callback(hObject, eventdata, handles)
function xUpperText_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function xLowerText_Callback(hObject, eventdata, handles)
function xLowerText_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function table = getTable(xr, errors)
sz = size(errors);
sz = sz(2);
i = 1;
while( i <= sz)
    table(i,3) = xr(i);
   table(i,4) = errors(i);
    i = i+1;
end

function table = getTableForFalseAndBisection(xl , xu, xr, errors)
sz = size(xr);
sz = sz(2);
i = 1;
while( i <= sz)
    table(i,1) = xl(i);
    table(i,2) = xu(i);
    table(i,3) = xr(i);
    table(i,4) = errors(i);
    i = i+1;
end
