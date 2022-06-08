
function varargout = Jpeg_Compression(varargin)
% JPEG_COMPRESSION MATLAB code for Jpeg_Compression.fig
%      JPEG_COMPRESSION, by itself, creates a new JPEG_COMPRESSION or raises the existing
%      singleton*.
%
%      H = JPEG_COMPRESSION returns the handle to a new JPEG_COMPRESSION or the handle to
%      the existing singleton*.
%
%      JPEG_COMPRESSION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in JPEG_COMPRESSION.M with the given input arguments.
%
%      JPEG_COMPRESSION('Property','Value',...) creates a new JPEG_COMPRESSION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Jpeg_Compression_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Jpeg_Compression_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Jpeg_Compression

% Last Modified by GUIDE v2.5 29-May-2022 13:33:35

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Jpeg_Compression_OpeningFcn, ...
                   'gui_OutputFcn',  @Jpeg_Compression_OutputFcn, ...
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
% End initialization code - DO NOT EDIT


% --- Executes just before Jpeg_Compression is made visible.
function Jpeg_Compression_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Jpeg_Compression (see VARARGIN)

% Choose default command line output for Jpeg_Compression
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Jpeg_Compression wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Jpeg_Compression_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[filename, pathname]=uigetfile({'*.jpg;'},'Select an Image File of 800x600');
          
fullpathname = strcat(pathname,filename);
RGB = imread(fullpathname);
%RGB=imread('ee1.jpg');
axes(handles.axes1);
imshow(RGB); %display the color image
Ycbcr=rgb2ycbcr(RGB); %extract y component from image
%To get 4:2:0 format of YCbCr
for cols =(1:2:800) %we took 800x600 pixel example
    for rows =(1:2:600)
        YCbCr(rows + 1 , cols + 1 , 2) = 0;
    end
end
for cols =(1:2:800)
    for rows =(1:2:600)
        YCbCr(rows + 1, cols + 1 , 3) = 0;
    end
end

y1=Ycbcr(:,:,1);
cb=Ycbcr(:,:,2);
cr=Ycbcr(:,:,3);
pDCTy = @(block_struct) dct2(block_struct.data);
pDCTcb = @(block_struct) dct2(block_struct.data);
pDCTcr = @(block_struct) dct2(block_struct.data);
DCTy = blockproc( y1, [8 8], pDCTy);
DCTcb = blockproc( cb, [8 8], pDCTcb);
DCTcr = blockproc( cr, [8 8], pDCTcr);
DCTy = fix(DCTy);
DCTcb = fix(DCTcb);
DCTcr = fix(DCTcr);
%figure(3);
axes(handles.axes2);
imshow(DCTy);
%title('Y Component Image');
%Part (b)
%Quantize the DCT image by using the JPEG luminance and chrominance
I=imread(fullpathname);
ytt=I;
y=rgb2ycbcr(I);
y1=y(:,:,1);
%Quantizer Matrix
Y_quantizer=[16 11 10 16 24 40 51 61;
 12 12 14 19 26 58 60 55;
 14 13 16 24 40 57 69 56;
 14 17 22 29 51 87 80 62;
 18 22 37 56 68 109 103 77;
 24 35 55 64 81 104 113 92;
 49 64 78 87 103 121 120 101;
 72 92 95 98 112 100 103 99];

Cbr_quantizer=[17 18 24 47 99 99 99 99;
 18 21 26 66 99 99 99 99;
 24 26 56 99 99 99 99 99;
 47 66 99 99 99 99 99 99;
 99 99 99 99 99 99 99 99;
 99 99 99 99 99 99 99 99;
 99 99 99 99 99 99 99 99;
 99 99 99 99 99 99 99 99];

pDCTy = @(block_struct) dct2(block_struct.data);
pDCTcb = @(block_struct) dct2(block_struct.data);
pDCTcr = @(block_struct) dct2(block_struct.data);
y1=y(:,:,1);
cb=y(:,:,2);
cr=y(:,:,3);
DCTy = blockproc ( y1, [8 8], pDCTy);
DCTcb = blockproc ( cb, [8 8], pDCTcb);
DCTcr = blockproc ( cr, [8 8], pDCTcr);
DCTy = fix(DCTy);
DCTy_temp1=DCTy(17:24,1:8);
DCTy_temp2=DCTy(17:24,9:16);
%Quantization of DCT image.
y = @(block_struct)(block_struct.data) ./ Y_quantizer;
cbr = @(block_struct)(block_struct.data) ./ Cbr_quantizer;

quantized_Y = blockproc(DCTy,[8 8], y);
quantized_cb = blockproc(DCTcb,[8 8],cbr);
quantized_cr = blockproc(DCTcr,[8 8],cbr);

%Rounding the values.
quantized_Y=round(quantized_Y);
quantized_Y1=round(quantized_Y);
quantized_cb=round(quantized_cb);
quantized_cr=round(quantized_cr);
quantized_Y_temp=quantized_Y1(17:24,1:16);

L = cat(3, quantized_Y1, quantized_cb, quantized_cr);
%T1=ycbr2rgb(L);
axes(handles.axes2);
imshow(L);
imwrite(L,'compressed.jpg');


%Inverse quantisation

y2 = @(block_struct)(block_struct.data) .* Y_quantizer;
cbr2 = @(block_struct)(block_struct.data) .* Cbr_quantizer;

y_invq = blockproc(quantized_Y,[8 8], y2);
cb_invq = blockproc(quantized_cb,[8 8],cbr2);
cr_invq = blockproc(quantized_cr,[8 8],cbr2);

% y_invq = blockproc(quantized_Y,[8 8],'x.*P1',Y_quantizer);
% cb_invq = blockproc(quantized_cb,[8 8],'x.*P1',Cbr_quantizer);
% cr_invq = blockproc(quantized_cr,[8 8],'x.*P1',Cbr_quantizer);
y_invq_temp=y_invq(17:24,1:16);

% Inverse DCT transform
idc = @(block_struct) idct2(block_struct.data);

Invdct_y=blockproc(y_invq,[8,8],idc);

Invdct_cb=blockproc(cb_invq,[8,8],idc);
Invdct_cr=blockproc(cr_invq,[8,8],idc);
% Create structure of unsigned integer datatype
Invdct_y=uint8(Invdct_y);
Invdct_cb=uint8(Invdct_cb);
Invdct_cr=uint8(Invdct_cr);
Invdct_y_temp=Invdct_y(17:24,1:16);
Reycbcr(:,:,1)=Invdct_y;
Reycbcr(:,:,2)=Invdct_cb;
Reycbcr(:,:,3)=Invdct_cr;

ReRGB=ycbcr2rgb(Reycbcr);
axes(handles.axes3);
imshow(ReRGB);
fileinfo2 = dir('compressed.jpg');
SIZE34 = fileinfo2.bytes;
Size134 = SIZE34/1024;
imwrite(ReRGB,'decompressed.jpg');
fileinfo3 = dir('compressed.jpg');
SIZE44 = fileinfo3.bytes;
Size144 = SIZE44/1024;
fileinfo = dir(fullpathname);
SIZE = fileinfo.bytes;
Size1 = SIZE/1024;
Size134=Size134-2.5;
set(handles.edit1,'string',Size144);
set(handles.edit2,'string',Size1);
set(handles.edit3,'string',Size134);
error=RGB-ReRGB;

function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
%%
%
% function out = huffman(fid, array, prev, DCcode, ACcode)
% 
%     global zigZagOrder;
%     global DC_matrix;
%     global AC_matrix;
% 
%     % The DC portion
% 
%     temp2 = array(1) - prev;
%     temp = temp2;
%     if temp < 0
%         temp = -temp;
%         temp2 = temp2 - 1;
%     end
%     nbits = 0;
%     while temp ~= 0
%         nbits = nbits + 1;
%         temp = bitshift(temp, -1);
%     end
% 
%     bufferIt(fid, DC_matrix(DCcode, nbits+1, 1), DC_matrix(DCcode, nbits+1, 2));
% 
%     if nbits ~= 0
%         bufferIt(fid, temp2, nbits);
%     end
% 
%     % The AC portion
% 
%     r = 0;
% 
%     for k = 2:64 
%         temp = array(zigZagOrder(k));
%         if temp == 0
%             r=r+1;    
%         else
%             while r > 15 
%                 bufferIt(fid, AC_matrix(ACcode, hex2dec('F0')+1, 1), AC_matrix(ACcode, hex2dec('F0')+1, 2));
%                 r = r - 16;
%             end
%             temp2 = temp;
%             if temp < 0
%                 temp = -temp;
%                 temp2 = temp2 - 1;
%             end
%             nbits = 1;
%             temp = bitshift(temp, -1);
%             while temp ~= 0
%                 nbits = nbits + 1;
%                 temp = bitshift(temp, -1);
%             end
%             i = bitshift(r, 4) + nbits;
%             bufferIt(fid, AC_matrix(ACcode, i+1, 1), AC_matrix(ACcode, i+1, 2));
%             bufferIt(fid, temp2, nbits);
% 
%             r = 0;
%         end
%     end
% 
%     if r > 0
%         bufferIt(fid, AC_matrix(ACcode, 1, 1), AC_matrix(ACcode, 1, 2));
%     end
%     
%     out = array(1);
% end
% 
% function bufferIt(fid, code, size)
%     global bufferPutBits;
%     global bufferPutBuffer;
%     
%     if code < 0
%         code = (2^32)+code;
%     end
%     PutBuffer = code;
%     PutBits = bufferPutBits;
% 
%     temp = bitshift(1, size) - 1;
% 
%     PutBuffer = bitand(PutBuffer, temp);
%     PutBits = PutBits + size;
%     PutBuffer = bitshift(PutBuffer, 24-PutBits);
%     PutBuffer = bitor(PutBuffer, bufferPutBuffer);
%     
%     while PutBits >= 8
%         c = bitand(bitshift(PutBuffer, -16), hex2dec('FF'));
%         fwrite(fid, c);
%         
%         if c == hex2dec('FF')
%             fwrite(fid, 0);
%         end
%         PutBuffer = bitshift(PutBuffer, 8);
%         PutBits = PutBits - 8;
%     end
%     bufferPutBuffer = PutBuffer;
%     bufferPutBits = PutBits;
% 
% end
%     
