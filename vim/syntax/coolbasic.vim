" Vim syntax file
" Language: CoolBasic
" Maintainer: Esa Lakaniemi <esalaka@gmail.com>
" Last Change: 2013 June 8
" Remark: Might still be imperfect

if version < 600
	syn clear
elseif exists("b:current_syntax")
	finish
endif

syn case ignore

syn keyword coolbasicType Integer Float String Short Byte
syn keyword coolbasicConditional If Then Else ElseIf EndIf Select EndSelect
syn keyword coolbasicRepeat Repeat Forever Until While Wend For To Next Each
syn keyword coolbasicLabel Case Default
syn keyword coolbasicStructure Type EndType Field

syn keyword coolbasicFunction New First Last After Before ConvertToInteger ConvertTotype Read Int Float Roundup RoundDown Abs Sqrt Sin Cos Tan Asin Acos Atan GetAngle GetAngle2 Log Log10 Rnd Rand Min Max CurveValue CurveAngle WrapAngle Distance Distance2 BoxOverlap Str Left Right Mid Replace Instr Upper Lower Trim Lset Rset Chr Asc Len Hex Bin String Flip StrInsert StrRemove StrMove CountWords GetWord LoadFont TextWidth TextHeight OpenToRead OpenToWrite OpenToEdit FileOffset FindInFile CurrentDir FileExists IsDirectory FileSize EOF ReadByte ReadShort ReadInt ReadFloat ReadString ReadLine MakeMEMBlock MEMBlockSize PeekByte PeekShort PeekInt PeekFloat Input KeyDown KeyHit KeyUp GetKey MouseDown MouseHit MouseUp GetMouse WaitMouse MouseX MouseY MouseWX MouseWY MouseZ MouseMoveX MouseMoveY MouseMoveZ LeftKey RightKey UpKey DownKey EscapeKey Date Time Timer CommandLine GetEXEName FPS CRC32 LoadSound SoundPlaying PlayAnimation AnimationWidth AnimationHeight AnimationPlaying LoadImage LoadAnimImage MakeImage CloneImage ImageWidth ImageHeight ImagesOverlap ImagesCollide Image GetPixel GetPixel2 GetRGB ScreenWidth ScreenHeight ScreenDepth GFXModeExists LoadObject LoadAnimObject MakeObject MakeObjectFloor CloneObject PickedObject PickedX PickedY PickedAngle ObjectX ObjectY ObjectAngle ObjectSizeX ObjectSizeY ObjectPlaying ObjectFrame ObjectsOverlap ObjectSight CountCollisions GetCollision CollisionX CollisionY CollisionAngle NextObject CameraX CameraY CameraAngle LoadMap MakeMap GetMap GetMap2 MapWidth MapHeight MakeEmitter Randomize SetFont DeleteFont Text CenterText VerticalText Print Write Locate AddText ClearText CloseFile SeekFile StartSearch EndSearch ChDir MakeDir CopyFile DeleteFile Execute WriteByte WriteShort WriteInt WriteFloat WriteString WriteLine DeleteMEMBlock ResizeMEMBlock MemCopy PokeByte PokeShort PokeInt PokeFloat CloseInput WaitKey ClearKeys PositionMouse WaitMouse ShowMouse ClearMouse SafeExit Wait SetWindow MakeError SaveProgram LoadProgram GotoSavedLocation FrameLimit Encrypt Decrypt CallDLL Errors Wait SetWindow MakeError SaveProgram LoadProgram GotoSavedLocation FrameLimit Encrypt Decrypt CallDLL Errors Wait SetWindow MakeError SaveProgram LoadProgram GotoSavedLocation FrameLimit Encrypt Decrypt CallDLL Errors Wait SetWindow MakeError SaveProgram LoadProgram GotoSavedLocation FrameLimit Encrypt Decrypt CallDLL Errors PlaySound SetSound StopSound DeleteSound StopAnimation DrawAnimation SaveImage DrawImage DrawGhostImage DrawImageBox MaskImage DefaultMask ResizeImage RotateImage PickImageColor PickImageColor2 HotSpot DeleteImage Screen Lock Unlock PutPixel PutPixel2 CopyBox Color ClsColor Cls Dot Line Box Circle Ellipse PickColor ScreenGamma DrawToImage DrawToScreen DrawToWorld Smooth2D ScreenShot UpdateGame DrawGame DrawScreen DeleteObject ClearObjects MoveObject TranslateObject PositionObject ScreenPositionObject TurnObject RotateObject PointObject CloneObjectPosition CloneObjectOrientation ObjectOrder MaskObject ShowObject DefaultVisible PaintObject GhostObject MirrorObject ObjectRange ObjectInteger ObjectFloat ObjectString ObjectPickable ObjectPick PixelPick ObjectLife PlayObject LoopObject StopObject ResetObjectCollision SetupCollision ClearCollisions InitObjectList UpdateGame DrawGame DrawToWorld CloneCameraPosition CloneCameraOrientation CameraFollow CameraPick PointCamera TurnCamera RotateCamera MoveCamera TranslateCamera PositionCamera EditMap SetMap SetTile ParticleMovement ParticleAnimation ParticleEmission
syn keyword coolbasicKeyword Exit Goto Gosub Return Function EndFunction Dim Redim ClearArray Const Global Data Restore Include

" Special cases for End
" None needed for keyword because Function and End are both keywords
syn match coolbasicKeyword /End$/
syn match coolbasicConditional /\(End If\|End Select\)/
syn match coolbasicStructure /End Type/

syn match coolbasicOperator /[\/\*\-+<>]/
syn keyword coolbasicOperator Mod Shl Shr Sar And Or Xor Not

syn match coolbasicComment /'.*/
syn match coolbasicComment /\/\/.*/
syn region coolbasicComment start=/REMSTART/ end=/REMEND/

syn match coolbasicNumber /\<-*\d\+/
syn match coolbasicFloat /\<-*\d*\.\d+/
syn region coolbasicString start=/"/ end=/"/ oneline
syn keyword coolbasicBoolean True False

" -----
" LINKS
" -----

hi link coolbasicType Type
hi link coolbasicConditional Conditional
hi link coolbasicRepeat Repeat
hi link coolbasicLabel Label
hi link coolbasicStructure Structure
hi link coolbasicFunction Function
hi link coolbasicKeyword Keyword

hi link coolbasicOperator Operator

hi link coolbasicComment Comment

hi link coolbasicString String
hi link coolbasicNumber Number
hi link coolbasicFloat Float
hi link coolbasicBoolean Boolean

" -----
" FINALLY
" -----

let b:current_syntax="CoolBasic"
