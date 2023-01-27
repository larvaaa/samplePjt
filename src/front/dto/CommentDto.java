package front.dto;

import common.dto.CommonDto;

public class CommentDto extends CommonDto {
	
	private Long cseq;
	private Long bseq;
	private Long cgrp;
	private int cdepth;
	private String content;
	private String writer;
	
	public Long getCseq() {
		return cseq;
	}
	public void setCseq(Long cseq) {
		this.cseq = cseq;
	}
	public Long getBseq() {
		return bseq;
	}
	public void setBseq(Long bseq) {
		this.bseq = bseq;
	}
	public Long getCgrp() {
		return cgrp;
	}
	public void setCgrp(Long cgrp) {
		this.cgrp = cgrp;
	}
	public int getCdepth() {
		return cdepth;
	}
	public void setCdepth(int cdepth) {
		this.cdepth = cdepth;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	
	
}
