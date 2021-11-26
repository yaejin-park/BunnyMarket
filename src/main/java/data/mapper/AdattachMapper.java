package data.mapper;

import java.util.List;

import data.dto.AdattachDTO;

public interface AdattachMapper {
	public void insert(AdattachDTO dto);
	public void delete(String uuid);
	public List<AdattachDTO> findByIdx(int idx);
}
