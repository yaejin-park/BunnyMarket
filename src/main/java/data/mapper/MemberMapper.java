package data.mapper;

import java.util.HashMap;
import org.apache.ibatis.annotations.Mapper;
import data.dto.MemberDTO;

@Mapper
public interface MemberMapper {
	public void insertMember(MemberDTO dto);
	public int getIdCheck(String id);
	public int getNickCheck(String nick);
	public String getPw(String id);
	public String getNick(String id);
	public MemberDTO getMemberId(String id);
	public String getIdFindMember(HashMap<String, String> map);
	public String currentUserName(String id);
	public String currentUserNickName(String id);
	public String currentUserType(String id);
	public String getLocal(String id);
	public void updateLocal(HashMap<String, String> map);
	public String checkPw(HashMap<String, String> map);
	public void updatePw(HashMap<String, String> map);
	public void updateProfile(HashMap<String, String> map);
	public void updateNickName(HashMap<String, String> map);
	public void deleteMember(String id);
}
