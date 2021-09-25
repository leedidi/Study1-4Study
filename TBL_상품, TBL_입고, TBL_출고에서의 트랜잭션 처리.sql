
--��1. TBL_��ǰ, TBL_�԰�, TBL_��� �� ���迡��
-- �԰����, �������� Ʈ����� ó���� �̷���� �� �ֵ���
-- TRG_IBGO Ʈ���Ÿ� �籸���Ѵ�.


CREATE OR REPLACE TRIGGER TRG_IBGO
        AFTER 
        INSERT OR DELETE OR UPDATE ON TBL_�԰�
        FOR EACH ROW
BEGIN
   IF (INSERTING) 
       THEN UPDATE TBL_��ǰ
             SET ������ = ������ + :NEW.�԰����
             WHERE ��ǰ�ڵ� = :NEW.��ǰ�ڵ�;
    
   ELSIF (UPDATING)
        THEN UPDATE TBL_��ǰ
            SET ������ = ������ - :OLD.�԰���� + :NEW.�԰����
            WHERE ��ǰ�ڵ� = :NEW.��ǰ�ڵ�;
            
  ELSIF (DELETING)
         THEN  UPDATE TBL_��ǰ
            SET ������ = ������ - :OLD.�԰����
            WHERE ��ǰ�ڵ� = :OLD.��ǰ�ڵ�;
            
  END IF;

END;

--�� 2. TBL_��ǰ, TBL_�԰�, TBL_��� �� ���迡��
-- ������, �������� Ʈ����� ó���� �̷���� �� �ֵ���
-- TRG_CHULGO Ʈ���Ÿ� �ۼ��Ѵ�.

CREATE OR REPLACE TRIGGER TRG_CHULGO
        AFTER 
        INSERT OR DELETE OR UPDATE ON TBL_���
        FOR EACH ROW
BEGIN
    IF (INSERTING) 
        THEN  UPDATE TBL_��ǰ
             SET ������ = ������ - :NEW.������
             WHERE ��ǰ�ڵ� = :NEW.��ǰ�ڵ�;
             
    ELSIF (UPDATING)
        THEN UPDATE TBL_��ǰ
             SET ������ = ������ + :OLD.������ - :NEW.������
             WHERE ��ǰ�ڵ� = :NEW.��ǰ�ڵ�;
             
    ELSIF (DELETING)
          THEN UPDATE TBL_��ǰ
             SET ������ = ������ + :OLD.������
             WHERE ��ǰ�ڵ� = :OLD.��ǰ�ڵ�;
    END IF;
    --INSERT -> NEW / DELETE -> OLD...
END;