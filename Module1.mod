MODULE Module1
    PROC main()
        ! ------------------------------------
        !   Copyright 2020 Andrea de Giorgio  
        !   Email: andreadg@kth.se
        !
        !   Please, cite: A. de Giorgio and L. Wang, "Artificial Intelligence Control in
        !   4D Cylindrical Space for Industrial Robotic Applications," in IEEE Access,
        !   vol. 8, pp. 174833-174844, 2020, doi: 10.1109/ACCESS.2020.3026193.
        ! ------------------------------------
        VAR socketdev server_socket;
        VAR socketdev client_socket;
        VAR string receive_string;
        VAR string client_ip;
        VAR jointtarget rtemp;
        CONST jointtarget calib_pos := [ [ 0, 0, 0, 0, 0, 0], [ 9E9, 9E9, 9E9, 9E9, 9E9, 9E9] ];
        VAR bool ok;
        !VAR string targetString;

        MoveAbsJ calib_pos,v1000,z50,tool0\WObj:=wobj0;
        rtemp := calib_pos;
        !targetString := "[1;2;3;4;5;6]";
        !rtemp := StringToJointTarget(targetString);
        SocketCreate server_socket;
        SocketBind server_socket, "127.0.0.1", 4000;
        SocketListen server_socket;

        ! Waiting for a connection request
        WHILE TRUE DO
            SocketAccept server_socket, client_socket\ClientAddress:=client_ip\Time:=WAIT_MAX;
            !SocketSend client_socket \Str := "Hello client with ip-addres " +client_ip;
            !SocketReceive client_socket \Str := receive_string;
            !ok := StrToVal(receive_string,rtemp.robax.rax_1);
            !SocketSend client_socket \Str := "Joint 1 received: " + ValToStr(rtemp.robax.rax_1);
            !SocketReceive client_socket \Str := receive_string;
            !ok := StrToVal(receive_string,rtemp.robax.rax_2);
            !SocketSend client_socket \Str := "Joint 2 received: " + ValToStr(rtemp.robax.rax_2);
            !SocketReceive client_socket \Str := receive_string;
            !ok := StrToVal(receive_string,rtemp.robax.rax_3);
            !SocketSend client_socket \Str := "Joint 3 received: " + ValToStr(rtemp.robax.rax_3);
            !SocketReceive client_socket \Str := receive_string;
            !ok := StrToVal(receive_string,rtemp.robax.rax_4);
            !SocketSend client_socket \Str := "Joint 4 received: " + ValToStr(rtemp.robax.rax_4);
            !SocketReceive client_socket \Str := receive_string;
            !ok := StrToVal(receive_string,rtemp.robax.rax_5);
            !SocketSend client_socket \Str := "Joint 5 received: " + ValToStr(rtemp.robax.rax_5);
            !SocketReceive client_socket \Str := receive_string;
            !ok := StrToVal(receive_string,rtemp.robax.rax_6);
            !SocketSend client_socket \Str := "Joint 6 received: " + ValToStr(rtemp.robax.rax_6);
            
            !SocketSend client_socket \Str := "R";
            SocketReceive client_socket \Str := receive_string;
            SocketClose client_socket;
            
            rtemp := StringToJointTarget(receive_string);
            MoveAbsJ rtemp,v100,z50,tool0\WObj:=wobj0;
        ENDWHILE
    ERROR
        RETRY;
    UNDO
        SocketClose server_socket;
        SocketClose client_socket;
        
    ENDPROC
    
    FUNC jointtarget StringToJointTarget(string value)
        VAR jointtarget tmpTarget;
        VAR bool b;
        CONST jointtarget calib_pos := [ [ 0, 0, 0, 0, 0, 0], [ 9E9, 9E9, 9E9, 9E9, 9E9, 9E9] ];
        VAR num posJ1;
        VAR num posJ2;
        VAR num posJ3;
        VAR num posJ4;
        VAR num posJ5;
        VAR num posJ6;
        
        tmpTarget := calib_pos;
        !Search values in "[1;2;3;4;5;6]"
        
        posJ1 := StrFind(value,1,";");
        posJ2 := StrFind(value,posJ1+1,";");
        posJ3 := StrFind(value,posJ2+1,";");
        posJ4 := StrFind(value,posJ3+1,";");
        posJ5 := StrFind(value,posJ4+1,";");
        posJ6 := StrFind(value,posJ5+1,"]");
        
        b := StrToVal(StrPart(value,2,posJ1-2),tmpTarget.robax.rax_1);
        b := StrToVal(StrPart(value,posJ1+1,posJ2-posJ1-1),tmpTarget.robax.rax_2);
        b := StrToVal(StrPart(value,posJ2+1,posJ3-posJ2-1),tmpTarget.robax.rax_3);
        b := StrToVal(StrPart(value,posJ3+1,posJ4-posJ3-1),tmpTarget.robax.rax_4);
        b := StrToVal(StrPart(value,posJ4+1,posJ5-posJ4-1),tmpTarget.robax.rax_5);
        b := StrToVal(StrPart(value,posJ5+1,posJ6-posJ5-1),tmpTarget.robax.rax_6);
        RETURN tmpTarget;
    ENDFUNC
ENDMODULE