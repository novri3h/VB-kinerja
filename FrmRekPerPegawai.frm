VERSION 5.00
Object = "{00025600-0000-0000-C000-000000000046}#5.2#0"; "Crystl32.OCX"
Begin VB.Form FrmRekPerpegawai 
   BackColor       =   &H0080C0FF&
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Rekomendasi Per-Pegawai"
   ClientHeight    =   1320
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   4620
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   1320
   ScaleWidth      =   4620
   Begin Crystal.CrystalReport Lap 
      Left            =   1620
      Top             =   1440
      _ExtentX        =   741
      _ExtentY        =   741
      _Version        =   348160
      PrintFileLinesPerPage=   60
   End
   Begin VB.CommandButton Command3 
      Caption         =   "&Tutup"
      BeginProperty Font 
         Name            =   "Century"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   3540
      TabIndex        =   6
      Top             =   840
      Width           =   960
   End
   Begin VB.CommandButton Command2 
      Caption         =   "&Preview"
      BeginProperty Font 
         Name            =   "Century"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   2550
      TabIndex        =   5
      Top             =   840
      Width           =   960
   End
   Begin VB.CommandButton Command1 
      Caption         =   "&Cetak"
      BeginProperty Font 
         Name            =   "Century"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   1560
      TabIndex        =   4
      Top             =   840
      Width           =   960
   End
   Begin VB.TextBox Text1 
      BeginProperty Font 
         Name            =   "Century"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   330
      Left            =   1260
      TabIndex        =   3
      Text            =   "Text1"
      Top             =   435
      Width           =   3255
   End
   Begin VB.ComboBox Combo1 
      BeginProperty Font 
         Name            =   "Century"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   345
      Left            =   1260
      TabIndex        =   0
      Text            =   "Combo1"
      Top             =   75
      Width           =   1995
   End
   Begin VB.Label Label2 
      BackStyle       =   0  'Transparent
      Caption         =   "Nama Pegawai"
      BeginProperty Font 
         Name            =   "Century"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   330
      Left            =   60
      TabIndex        =   2
      Top             =   480
      Width           =   1860
   End
   Begin VB.Label Label1 
      BackStyle       =   0  'Transparent
      Caption         =   "NIP Pegawai"
      BeginProperty Font 
         Name            =   "Century"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   330
      Left            =   60
      TabIndex        =   1
      Top             =   120
      Width           =   1860
   End
End
Attribute VB_Name = "FrmRekPerpegawai"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
    Dim DbPegawai As Database
    Dim RecPegawai As Recordset
    
Private Sub Combo1_Change()
    Combo1_Click
End Sub

Private Sub Combo1_Click()
    RecPegawai.Seek "=", Combo1.Text
    If Not RecPegawai.NoMatch Then
        Text1.Text = RecPegawai!namapeg
        Command1.Enabled = True
        Command2.Enabled = True
    Else
        Text1.Text = ""
        Command1.Enabled = False
        Command2.Enabled = False
    End If
End Sub

Private Sub Command1_Click()
    Lap.ReportFileName = App.Path & "\daftarrekomendasi.rpt"
    Lap.DataFiles(0) = App.Path & "\pdam.mdb"
    Lap.WindowState = crptMaximized
    Lap.Destination = crptToPrinter
    Lap.ReplaceSelectionFormula "{pegawai.nip_peg}='" & Trim(Combo1.Text) & "'"
    Lap.Action = 2
End Sub

Private Sub Command2_Click()
    Lap.ReportFileName = App.Path & "\daftarrekomendasi.rpt"
    Lap.DataFiles(0) = App.Path & "\pdam.mdb"
    Lap.WindowState = crptMaximized
    Lap.Destination = crptToWindow
    Lap.ReplaceSelectionFormula "{pegawai.nip_peg}='" & Trim(Combo1.Text) & "'"
    Lap.Action = 2
End Sub

Private Sub Command3_Click()
    Unload Me
End Sub

Private Sub Form_activate()
    Set DbPegawai = OpenDatabase(App.Path & "\pdam.mdb")
    Set RecPegawai = DbPegawai.OpenRecordset("pegawai")
    RecPegawai.Index = "idxpegawai"
    Text1.Text = ""
    Command1.Enabled = False
    Command2.Enabled = False
    Combo1.Clear
    Do While Not RecPegawai.EOF
        Combo1.AddItem RecPegawai!nip_peg
        RecPegawai.MoveNext
    Loop

End Sub
