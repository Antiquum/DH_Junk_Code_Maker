// DH Junk Code Maker 0.4
// (C) Doddy Hackman 2016

unit junk;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.ComCtrls, Vcl.Styles.Utils.Menus, Vcl.Styles.Utils.SysStyleHook,
  Vcl.Styles.Utils.SysControls, Math, Vcl.Menus, Vcl.Imaging.pngimage,
  Vcl.ImgList;

type
  TFormHome = class(TForm)
    imgLogo: TImage;
    gbOutput: TGroupBox;
    mmOutput: TMemo;
    gbEnterLength: TGroupBox;
    txtLength: TEdit;
    udLength: TUpDown;
    gbType: TGroupBox;
    cmbOptions: TComboBox;
    gbOptions: TGroupBox;
    btnGenerate: TButton;
    ppOptions: TPopupMenu;
    copy: TMenuItem;
    clear: TMenuItem;
    ilIconos: TImageList;
    procedure btnGenerateClick(Sender: TObject);
    procedure clearClick(Sender: TObject);
    procedure copyClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormHome: TFormHome;

implementation

{$R *.dfm}
// Functions

function dh_generate_string(option: string; length_string: integer): string;
const
  letters1: array [1 .. 26] of string = ('a', 'b', 'c', 'd', 'e', 'f', 'g', 'h',
    'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w',
    'x', 'y', 'z');
const
  letters2: array [1 .. 26] of string = ('A', 'B', 'C', 'D', 'E', 'F', 'G', 'H',
    'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W',
    'X', 'Y', 'Z');
const
  numbers: array [1 .. 10] of string = ('0', '1', '2', '3', '4', '5', '6', '7',
    '8', '9');

const
  cyrillic: array [1 .. 44] of string = ('А', 'Б', 'В', 'Г', 'Д', 'Е', 'Ж', 'Ѕ',
    'З', 'И', 'І', 'К', 'Л', 'М', 'Н', 'О', 'П', 'Р', 'С', 'Т', 'Ѹ', 'Ф', 'Х',
    'Ѡ', 'Ц', 'Ч', 'Ш', 'Щ', 'Ъ', 'Ы', 'Ь', 'Ѣ', 'Ю', 'Ꙗ', 'Ѥ', 'Ѧ', 'Ѩ', 'Ѫ',
    'Ѭ', 'Ѯ', 'Ѱ', 'Ѳ', 'Ѵ', 'Ҁ');

const
  no_idea1: array [1 .. 13] of string = ('๏', '๐', '๑', '๒', '๓', '๔', '๕', '๖',
    '๗', '๘', '๙', '๚', '๛');

const
  no_idea2: array [1 .. 28] of string = ('ﷲ', 'ﺀ', 'ﺁ', 'ﺂ', 'ﺃ', 'ﺄ', 'ﺅ', 'ﺆ',
    'ﺇ', 'ﺈ', 'ﺉ', 'ﺊ', 'ﺋ', 'ﺌ', 'ﺍ', 'ﺎ', 'ﺏﺐ', 'ﺑ', 'ﺒ', 'ﺓ', 'ﺔ', 'ﺕ', 'ﺖ',
    'ﺗ', 'ﺘ', 'ﺙ', 'ﺚ', 'ﺛﺜ');

const
  no_idea3: array [1 .. 13] of string = ('٥٦', '٧', '٨', '٩', 'ﾎ', '么', 'ﾒ',
    '_', 'ｬ', '`', 'ｦ', '_', 'ｶ');

const
  no_idea4: array [1 .. 26] of string = ('₪', '₫', '€', '℅', 'l', '№', '™', 'Ω',
    'e', '⅛', '⅜', '⅝', '⅞', '∂', '∆', '∏', '∑', '-', '/', '·', 'v', '8', '∫',
    '˜', '≠', '=');

const
  no_idea5: array [1 .. 33] of string = ('∃', '∧', '∠', '∨', '∩', '⊂', '⊃', '∪',
    '⊥', '∀', 'Ξ', 'Γ', 'ɐ', 'ə', 'ɘ', 'ε', 'β', 'ɟ', 'ɥ', 'ɯ', 'ɔ', 'и', '๏',
    'ɹ', 'ʁ', 'я', 'ʌ', 'ʍ', 'λ', 'ч', '∞', 'Σ', 'Π');

const
  no_idea6: array [1 .. 32] of string = ('ا', 'ب', 'پ', 'ت', 'ث', 'ج', 'چ', 'ح',
    'خ', 'د', 'ذ', 'ر', 'ز', 'ژ', 'س', 'ش', 'ص', 'ض', 'ط', 'ظ', 'ع', 'غ', 'ف',
    'ق', 'ک', 'گ', 'ل', 'م', 'ن', 'و', 'ه', 'ی');
var
  code: string;
  gen_now: string;
  i: integer;
  index: integer;
begin

  gen_now := '';

  for i := 1 to length_string do
  begin
    if (option = '1') then
    begin
      gen_now := gen_now + letters1[RandomRange(1, Length(letters1) + 1)];
    end
    else if (option = '2') then
    begin
      gen_now := gen_now + letters2[RandomRange(1, Length(letters2) + 1)];
    end
    else if (option = '3') then
    begin
      gen_now := gen_now + numbers[RandomRange(1, Length(numbers) + 1)];
    end
    else if (option = '4') then
    begin
      gen_now := gen_now + cyrillic[RandomRange(1, Length(cyrillic) + 1)];
    end
    else if (option = '5') then
    begin
      gen_now := gen_now + no_idea1[RandomRange(1, Length(no_idea1) + 1)];
    end
    else if (option = '6') then
    begin
      gen_now := gen_now + no_idea2[RandomRange(1, Length(no_idea2) + 1)];
    end
    else if (option = '7') then
    begin
      gen_now := gen_now + no_idea3[RandomRange(1, Length(no_idea3) + 1)];
    end
    else if (option = '8') then
    begin
      gen_now := gen_now + no_idea4[RandomRange(1, Length(no_idea4) + 1)];
    end
    else if (option = '9') then
    begin
      gen_now := gen_now + no_idea5[RandomRange(1, Length(no_idea5) + 1)];
    end
    else if (option = '10') then
    begin
      gen_now := gen_now + no_idea6[RandomRange(1, Length(no_idea6) + 1)];
    end
    else
    begin
      gen_now := gen_now + letters1[RandomRange(1, Length(letters1) + 1)];
    end;
  end;
  code := gen_now;

  Result := code;
end;

function message_box(title, message_text, type_message: string): string;
begin
  if not(title = '') and not(message_text = '') and not(type_message = '') then
  begin
    try
      begin
        if (type_message = 'Information') then
        begin
          MessageBox(FormHome.Handle, PChar(message_text), PChar(title),
            MB_ICONINFORMATION);
        end
        else if (type_message = 'Warning') then
        begin
          MessageBox(FormHome.Handle, PChar(message_text), PChar(title),
            MB_ICONWARNING);
        end
        else if (type_message = 'Question') then
        begin
          MessageBox(FormHome.Handle, PChar(message_text), PChar(title),
            MB_ICONQUESTION);
        end
        else if (type_message = 'Error') then
        begin
          MessageBox(FormHome.Handle, PChar(message_text), PChar(title),
            MB_ICONERROR);
        end
        else
        begin
          MessageBox(FormHome.Handle, PChar(message_text), PChar(title),
            MB_ICONINFORMATION);
        end;
        Result := '[+] MessageBox : OK';
      end;
    except
      begin
        Result := '[-] Error';
      end;
    end;
  end
  else
  begin
    Result := '[-] Error';
  end;
end;

//

procedure TFormHome.btnGenerateClick(Sender: TObject);
var
  id: string;
  i, y: integer;
  vars, vars2, name, name2, value, value2: string;
  strings, strings2: string;
  functions, code: string;
  limit_random: integer;
begin

  if (StrToInt(txtLength.Text) > 0) then
  begin

    if (cmbOptions.ItemIndex = 0) then
    begin
      for i := 1 to StrToInt(txtLength.Text) do
      begin
        name := dh_generate_string('1', 5);
        value := dh_generate_string('1', 20);
        mmOutput.Lines.Add('const ' + name + '=' + '''' + value + '''' + ';');
      end;
      mmOutput.Lines.Add('');
    end
    else if (cmbOptions.ItemIndex = 1) then
    begin

      vars := 'var ';
      strings := '';

      for i := 1 to StrToInt(txtLength.Text) do
      begin
        name := dh_generate_string('1', 5);
        value := dh_generate_string('1', 20);
        if (i = StrToInt(txtLength.Text)) then
        begin
          vars := vars + name + ':string;';
        end
        else
        begin
          vars := vars + name + ',';
        end;
        if (i = StrToInt(txtLength.Text)) then
        begin
          strings := strings + name + ':=' + '''' + value + '''' + ';';
        end
        else
        begin
          strings := strings + name + ':=' + '''' + value + '''' + ';' +
            sLineBreak;
        end;
      end;

      id := dh_generate_string('1', 5);

      code := 'procedure gen_vars_' + id + ';' + sLineBreak + vars + sLineBreak
        + 'begin' + sLineBreak + strings + sLineBreak + 'end;';

      mmOutput.Lines.Add(code);
      mmOutput.Lines.Add('');

    end
    else if (cmbOptions.ItemIndex = 2) then
    begin
      vars := 'var i,y:integer;';
      strings := '';
      for i := 1 to StrToInt(txtLength.Text) do
      begin
        value := dh_generate_string('3', 2);

        if (i = StrToInt(txtLength.Text)) then
        begin
          strings := strings + 'i := 0;' + sLineBreak + 'y := 0;' + sLineBreak +
            sLineBreak;
          strings := strings + 'for i := 0 to ' + value + ' do' + sLineBreak +
            'begin' + sLineBreak + 'inc(y);' + sLineBreak + 'end;';
        end
        else
        begin
          strings := strings + 'i := 0;' + sLineBreak + 'y := 0;' + sLineBreak +
            sLineBreak;
          strings := strings + 'for i := 0 to ' + value + ' do' + sLineBreak +
            'begin' + sLineBreak + 'inc(y);' + sLineBreak + 'end;' + sLineBreak
            + sLineBreak;
        end;
      end;

      id := dh_generate_string('1', 5);

      code := 'procedure gen_fors_' + id + ';' + sLineBreak + vars + sLineBreak
        + 'begin' + sLineBreak + strings + sLineBreak + 'end;';

      mmOutput.Lines.Add(code);
      mmOutput.Lines.Add('');

    end
    else if (cmbOptions.ItemIndex = 3) then
    begin
      code := '';
      functions := '';

      for i := 1 to StrToInt(txtLength.Text) do
      begin
        vars := 'var ';
        strings := '';
        limit_random := StrToInt(dh_generate_string('3', 1));
        if (limit_random = 0) then
        begin
          limit_random := 5;
        end;
        for y := 1 to limit_random do
        begin
          name := dh_generate_string('1', 5);
          value := dh_generate_string('1', 20);
          if (y = limit_random) then
          begin
            vars := vars + name + ':string;';
          end
          else
          begin
            vars := vars + name + ',';
          end;
          if (y = limit_random) then
          begin
            strings := strings + name + ':=' + '''' + value + '''' + ';';
          end
          else
          begin
            strings := strings + name + ':=' + '''' + value + '''' + ';' +
              sLineBreak;
          end;
        end;

        id := dh_generate_string('1', 5);

        if (i = StrToInt(txtLength.Text)) then
        begin
          functions := 'function gen_vars_' + id + '():string;' + sLineBreak +
            vars + sLineBreak + 'begin' + sLineBreak + strings + sLineBreak +
            'Result :=' + '''' + id + '''' + ';' + sLineBreak + 'end;' +
            sLineBreak;
        end
        else
        begin
          functions := 'function gen_vars_' + id + '():string;' + sLineBreak +
            vars + sLineBreak + 'begin' + sLineBreak + strings + sLineBreak +
            'Result :=' + '''' + id + '''' + ';' + sLineBreak + 'end;' +
            sLineBreak + sLineBreak;
        end;

        code := code + functions;

      end;

      mmOutput.Lines.Add(code);
      // mmOutput.Lines.Add('');
    end
    else if (cmbOptions.ItemIndex = 4) then
    begin

      code := '';

      for i := 1 to StrToInt(txtLength.Text) do
      begin

        vars := 'var i,y:integer;';
        strings := '';
        limit_random := StrToInt(dh_generate_string('3', 1));

        if (limit_random = 0) then
        begin
          limit_random := 5;
        end;
        for y := 1 to limit_random do
        begin
          value := dh_generate_string('3', 2);

          if (i = limit_random) then
          begin
            strings := strings + 'i := 0;' + sLineBreak + 'y := 0;' +
              sLineBreak;
            strings := strings + 'for i := 0 to ' + value + ' do' + sLineBreak +
              'begin' + sLineBreak + 'inc(y);' + sLineBreak + 'end;' +
              sLineBreak;
          end
          else
          begin
            strings := strings + 'i := 0;' + sLineBreak + 'y := 0;' +
              sLineBreak;
            strings := strings + 'for i := 0 to ' + value + ' do' + sLineBreak +
              'begin' + sLineBreak + 'inc(y);' + sLineBreak + 'end;' +
              sLineBreak;
          end;
        end;

        id := dh_generate_string('3', 5);

        if (i = StrToInt(txtLength.Text)) then
        begin
          functions := 'function gen_fors_' + id + '():integer();' + sLineBreak
            + vars + sLineBreak + 'begin' + sLineBreak + strings + 'Result :=' +
            id + ';' + sLineBreak + 'end;' + sLineBreak;
        end
        else
        begin
          functions := 'function gen_fors_' + id + '():integer();' + sLineBreak
            + vars + sLineBreak + 'begin' + sLineBreak + strings + 'Result :=' +
            id + ';' + sLineBreak + 'end;' + sLineBreak + sLineBreak;
        end;

        code := code + functions;

      end;

      mmOutput.Lines.Add(code);
      // mmOutput.Lines.Add('');

    end
    else if (cmbOptions.ItemIndex = 5) then
    begin

      code := '';
      functions := '';

      for i := 1 to StrToInt(txtLength.Text) do
      begin

        vars := 'var ';
        strings := '';
        vars2 := 'var ';
        strings2 := '';

        limit_random := StrToInt(dh_generate_string('3', 1));

        if (limit_random = 0) then
        begin
          limit_random := 5;
        end;
        for y := 1 to limit_random do
        begin
          name := dh_generate_string('1', 20);
          name2 := dh_generate_string('1', 20);
          value := dh_generate_string('1', 20);
          value2 := dh_generate_string('3', 2);

          if (y = limit_random) then
          begin
            vars := vars + name + ':string;';
          end
          else
          begin
            vars := vars + name + ',';
          end;

          if (y = limit_random) then
          begin
            strings := strings + name + ':=' + '''' + value + '''' + ';';
          end
          else
          begin
            strings := strings + name + ':=' + '''' + value + '''' + ';' +
              sLineBreak;
          end;

          vars2 := 'var i,y:integer;';

          if (y = limit_random) then
          begin
            strings2 := strings2 + 'i := 0;' + sLineBreak + 'y := 0;' +
              sLineBreak;
            strings2 := strings2 + 'for i := 0 to ' + value2 + ' do' +
              sLineBreak + 'begin' + sLineBreak + 'inc(y);' + sLineBreak +
              'end;' + sLineBreak;
          end
          else
          begin
            strings2 := strings2 + 'i := 0;' + sLineBreak + 'y := 0;' +
              sLineBreak;
            strings2 := strings2 + 'for i := 0 to ' + value2 + ' do' +
              sLineBreak + 'begin' + sLineBreak + 'inc(y);' + sLineBreak +
              'end;' + sLineBreak;
          end;
        end;

        id := dh_generate_string('1', 5);

        if (i = StrToInt(txtLength.Text)) then
        begin
          functions := 'function gen_functions_' + id + '():string;' +
            sLineBreak + vars + sLineBreak + vars2 + sLineBreak + 'begin' +
            sLineBreak + strings + sLineBreak + strings2 + 'Result :=' + '''' +
            id + '''' + ';' + sLineBreak + 'end;' + sLineBreak;
        end
        else
        begin
          functions := 'function gen_functions_' + id + '():string;' +
            sLineBreak + vars + sLineBreak + vars2 + sLineBreak + 'begin' +
            sLineBreak + strings + sLineBreak + strings2 + 'Result :=' + '''' +
            id + '''' + ';' + sLineBreak + 'end;' + sLineBreak + sLineBreak;
        end;

        code := code + functions;
      end;

      mmOutput.Lines.Add(code);

    end;

    message_box('DH Junk Code Maker 0.4', 'Enjoy the junk source',
      'Information');
  end
  else
  begin
    message_box('DH Junk Code Maker 0.4',
      'The length should be greater than zero', 'Warning');
  end;
end;

procedure TFormHome.clearClick(Sender: TObject);
begin
  mmOutput.clear;
  message_box('DH Junk Code Maker 0.4', 'Output cleaned', 'Information');
end;

procedure TFormHome.copyClick(Sender: TObject);
begin
  mmOutput.SelectAll;
  mmOutput.CopyToClipboard;
  message_box('DH Junk Code Maker 0.4', 'Output copied to the clipboard',
    'Information');
end;

end.

// The End ?
