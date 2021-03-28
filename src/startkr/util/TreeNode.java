package startkr.util;

import java.util.List;
import java.util.ArrayList;
import java.util.Map;

public class TreeNode {
	private TreeNode parentNode;
	private String parentKey;
	private String nodeKey;
	private int depth = 0;
	private List<TreeNode> childNodes;

	public TreeNode getParentNode() {
		return parentNode;
	}
	public void setParentNode(TreeNode parentNode) {
		this.parentNode = parentNode;
	}
	public String getParentKey() {
		return parentKey;
	}
	public void setParentKey(String parentKey) {
		this.parentKey = parentKey;
	}
	public String getNodeKey() {
		return nodeKey;
	}
	public void setNodeKey(String nodeKey) {
		this.nodeKey = nodeKey;
	}
	public int getDepth() {
		return depth;
	}
	public void setDepth(int depth) {
		this.depth = depth;
	}
	public List getChildNodes() {
		return childNodes;
	}
	public void setChildNodes(List childNodes) {
		this.childNodes = childNodes;
	}

	public void addChildNode( TreeNode node ) {
		if( childNodes == null ) childNodes = new ArrayList<TreeNode>();
		childNodes.add( node );
	}
	
	public void makeSubTree ( List<Map> nodes ) {
		if( nodes == null || nodes.size() < 1 ) return;
		if( this.nodeKey == null ) return;
		
		int nodeLen = nodes.size();
		for( int i = 0 ; i < nodeLen ; i++ ) {
			Map nodeInfo = nodes.get(i);
			if( this.nodeKey.equals( (String) nodeInfo.get("parentKey") ) ) {
				TreeNode treeNode = new TreeNode();
				this.addChildNode(treeNode);
				treeNode.setParentNode(this);
				nodes.remove(i);
			}
		}
		if( this.childNodes != null && this.childNodes.size() > 0 ) {
			for( int i = 0 ; i < this.childNodes.size() ; i++ ) {
				TreeNode node = this.childNodes.get(i);
				node.makeSubTree(nodes);
			}
		}
	}
	
	public List<TreeNode> getSubTreeList( List<TreeNode> treeList ) {
		if( treeList == null ) treeList = new ArrayList<TreeNode>();
		treeList.add(this);

		if( this.childNodes == null || this.childNodes.size() < 1 ) return treeList;

		for( int i = 0 ; i < this.childNodes.size() ; i++ ) {
			TreeNode node = this.childNodes.get(i);
			node.getSubTreeList(treeList);
		}
		return treeList;
	}
	
	public static List<Map> reorderTree( List<Map> dataList ) {
		List<Map> treeList = new ArrayList<Map>();
		
		if( dataList == null || dataList.size() < 1 ) return treeList;

		String nodeKey = "";
		String parentKey = "";
		// 최상위 노드
		for( int i = 0 ; i < dataList.size() ; i++ ) {
			Map data = dataList.get( i );
			parentKey = (String) data.get("parentKey");
			if( parentKey == null || 
				parentKey.length() < 1 || 
				parentKey.equals("ROOT") ) {
				data.put("depth", 0);
				treeList.add(0, data);
				dataList.remove( data );
			}
		}
		
		Integer depth = 0;
		int j = 0;
		int idx = 0;
		Boolean addFg = true;
		Boolean checkFg = true;
		
		while( dataList.size() > 0 ) {
			checkFg = true;
			Map data = dataList.get( 0 );
			nodeKey = (String) data.get("nodeKey");
			parentKey = (String) data.get("parentKey");

			for( int k = 0 ; k < treeList.size() ; k++ ) {
				Map tree = treeList.get( k );
				depth = (Integer)tree.get("depth");
				if( nodeKey.equals( (String)tree.get("parentKey") ) ) { 
					// 기존 LOOP-NODE가 대상 LOOP-NODE의 PARENT
					idx = k;
					data.put("depth", depth+1 );
					checkFg = false;
					break;
				} else if( parentKey.equals( (String) tree.get("nodeKey") ) ) { 
					// 기존 LOOP-NODE의 PARENT가 대상 LOOP-NODE
					idx = k+1;
					data.put("depth", depth-1 );
					checkFg = false;
					break;
				}
			}
			if( checkFg ) { // 연관성 체크
				for( int k = 0 ; k < dataList.size() ; k++ ) {
					Map cmpr = dataList.get( k );
					if( nodeKey.equals( (String) cmpr.get("parentKey") ) ) {
						idx = treeList.size();
						checkFg = false;
						break;
					} else if( parentKey.equals( (String) cmpr.get("nodeKey") ) ) {
						idx = treeList.size();
						checkFg = false;
						break;
					}
				}
			}

			if( checkFg == false ) {
				treeList.add(idx, data);
			}
			dataList.remove(0);

			// 이후 노드
			j = 0;
			while( j < dataList.size() && dataList.size() > 0 ) {
				addFg = true;
				Map cmpr = dataList.get( j );
				if( nodeKey.equals( (String) cmpr.get("parentKey") ) ) {
					// 기준 LOOP-NODE가 기존 LOOP-NODE의 PARENT
					treeList.add(idx+1, data);
					addFg = false;
				} else if( parentKey.equals( (String) cmpr.get("nodeKey") ) ) {
					// 기준 LOOP-NODE의 PARENT가 기존 LOOP-NODE
					treeList.add(idx, data);
					addFg = false;
				}
				if( addFg ) j++;
				else dataList.remove(j);
			}
		}
		
		
		return treeList;
	}
	
	public static List<Map> reorderTreeList( List<Map> dataList ) {
		if( dataList == null || dataList.size() < 1 ) return null;

		List<Map> treeList = new ArrayList<Map>();
		String nodeKey = "";
		String parentKey = "";
		Integer depth = 0;
		// 최상위 노드
		for( int i = 0 ; i < dataList.size() ; i++ ) {
			Map data = dataList.get( i );
			parentKey = (String) data.get("parentKey");
			if( parentKey == null || 
				parentKey.length() < 1 || 
				parentKey.equals("ROOT") ) {
				data.put("depth", 0);
				treeList.add(0, data);
				dataList.remove( data );
				break;
			}
		}

		Boolean useFg = false;
		Integer dataIdx = 0;
		Integer treeIdx = 0;

		while( dataIdx < dataList.size() && dataList.size() > 0 ) {
			Map data = dataList.get( dataIdx );
			nodeKey = (String) data.get("nodeKey");
			parentKey = (String) data.get("parentKey");
			useFg = false;
			
			System.out.print(" nodeKey : " + nodeKey);
			System.out.println(" parentKey : " + parentKey);
			// 대상 LOOP 비교
			for( int i = 0 ; i < treeList.size() ; i++ ) {
				Map tree = treeList.get( i );
				depth = (Integer)tree.get("depth");
				if( nodeKey.equals( (String)tree.get("parentKey") ) ) { 
					// 기존 LOOP-NODE가 대상 LOOP-NODE의 PARENT
					depth = depth-1;
					treeIdx = i;
					useFg = true;
					break;
				} else if( parentKey.equals( (String) tree.get("nodeKey") ) ) { 
					// 기존 LOOP-NODE의 PARENT가 대상 LOOP-NODE
					depth = depth+1;
					treeIdx = i+1;
					useFg = true;
					break;
				}
			}
			
			if( useFg ) {
				data.put("depth", depth );
				treeList.add(treeIdx, data);
				dataList.remove( data );

				// Tree에 추가된 NODE와 연관된 NODE 모두 설정
				for( int i = dataList.size()-1 ; i >= 0  ; i-- ) {
					Map cmpr = dataList.get( i );
					if( nodeKey.equals( (String) cmpr.get("parentKey") ) ) {
						cmpr.put("depth", depth+1 );
						treeList.add(treeIdx+1, cmpr);
						dataList.remove( cmpr );
						break;
					} else if( parentKey.equals( (String) cmpr.get("nodeKey") ) ) {
						cmpr.put("depth", depth-1 );
						treeList.add(treeIdx, cmpr);
						dataList.remove( cmpr );
						break;
					}
					System.out.println("cmpr treeIdx : " + treeIdx);
				}
				dataIdx = 0;
			} else {
				for( int i = 0 ; i < dataList.size() ; i++ ) {
					Map cmpr = dataList.get( i );
					if( nodeKey.equals( (String) cmpr.get("parentKey") ) ) {
						// 무한 루프 방지
						dataIdx = i;
						useFg = true;
						break;
					} else if( parentKey.equals( (String) cmpr.get("nodeKey") ) ) {
						// 무한 루프 방지
						dataIdx = i;
						useFg = true;
						break;
					}
				}
				if( useFg == false ) {
					// Tree에 포함될 수 없는 NODE 제거
					dataList.remove( data );
					dataIdx = 0;
				}
			}
		}
		return treeList;
	}

	public static TreeNode makeTree( List<Map> nodes ) {
		if( nodes == null || nodes.size() < 1 ) return null;

		List<TreeNode> treeInfos = new ArrayList<TreeNode>();
		for( int i = 0 ; i < nodes.size() ; i++ ) {
			Map nodeInfo = nodes.get(i);
			TreeNode treeNode = new TreeNode();
			treeNode.setParentKey((String) nodeInfo.get("parentKey"));
			treeNode.setNodeKey((String) nodeInfo.get("nodeKey"));
			treeInfos.add( treeNode );
		}
		
		TreeNode root = null;
		for( int i = 0 ; i < treeInfos.size() ; i++ ) {
			TreeNode thisNode = treeInfos.get( i );
			for( int j = 0 ; j < treeInfos.size() ; j++ ) {
				TreeNode node = treeInfos.get( j );
				if( thisNode.getNodeKey().equals( node.getParentKey() ) ) {
					thisNode.addChildNode( node );
					node.setParentNode( thisNode );
				}
			}
			if( thisNode.getNodeKey().equals( "ROOT" ) ) {
				root = thisNode;
			}
		}
		return root;
	}
}
